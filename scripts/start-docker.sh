#!/bin/bash

KEY="mykey"
CHAINID="torque_9000-1"
MONIKER="mymoniker"
DATA_DIR=$(mktemp -d -t torque-datadir.XXXXX)

echo "create and add new keys"
./torqued keys add $KEY --home $DATA_DIR --no-backup --chain-id $CHAINID --algo "eth_secp256k1" --keyring-backend test
echo "init Torque with moniker=$MONIKER and chain-id=$CHAINID"
./torqued init $MONIKER --chain-id $CHAINID --home $DATA_DIR
echo "prepare genesis: Allocate genesis accounts"
./torqued add-genesis-account \
"$(./torqued keys show $KEY -a --home $DATA_DIR --keyring-backend test)" 1000000000000000000atorque,1000000000000000000stake \
--home $DATA_DIR --keyring-backend test
echo "prepare genesis: Sign genesis transaction"
./torqued gentx $KEY 1000000000000000000stake --keyring-backend test --home $DATA_DIR --keyring-backend test --chain-id $CHAINID
echo "prepare genesis: Collect genesis tx"
./torqued collect-gentxs --home $DATA_DIR
echo "prepare genesis: Run validate-genesis to ensure everything worked and that the genesis file is setup correctly"
./torqued validate-genesis --home $DATA_DIR

echo "starting torque node $i in background ..."
./torqued start --pruning=nothing --rpc.unsafe \
--keyring-backend test --home $DATA_DIR \
>$DATA_DIR/node.log 2>&1 & disown

echo "started torque node"
tail -f /dev/null