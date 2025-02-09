<!--
order: 4
-->

# Run a Node

Configure and run an Torque node {synopsis}

## Pre-requisite Readings

- [Installation](./installation.md) {prereq}
- [`torqued`](./binary.md) {prereq}

## Automated deployment

Run the local node by running the `init.sh` script in the base directory of the repository.

::: warning
The script below will remove any pre-existing binaries installed. Use the manual deploy if you want
to keep your binaries and configuration files.
:::

```bash
./init.sh
```

## Manual deployment

The instructions for setting up a brand new full node from scratch are the the same as running a
[single node local testnet](./../../developers/localnet/single_node.md#manual-localnet).

## Start node

To start your node, just type:

```bash
torqued start --json-rpc.enable=true --json-rpc.api="eth,web3,net"
```

## Key Management

To run a node with the same key every time: replace `torqued keys add $KEY` in `./init.sh` with:

```bash
echo "your mnemonic here" | torqued keys add $KEY --recover
```

::: tip
Torque currently only supports 24 word mnemonics.
:::

You can generate a new key/mnemonic with:

```bash
torqued keys add $KEY
```

To export your torque key as an Ethereum private key (for use with [Metamask](./../../users/wallets/metamask.md) for example):

```bash
torqued keys unsafe-export-eth-key $KEY
```

For more about the available key commands, use the `--help` flag

```bash
torqued keys -h
```

### Keyring backend options

The instructions above include commands to use `test` as the `keyring-backend`. This is an unsecured
keyring that doesn't require entering a password and should not be used in production. Otherwise,
Torque supports using a file or OS keyring backend for key storage. To create and use a file
stored key instead of defaulting to the OS keyring, add the flag `--keyring-backend file` to any
relevant command and the password prompt will occur through the command line. This can also be saved
as a CLI config option with:

```bash
torqued config keyring-backend file
```

:::tip
For more information about the Keyring and its backend options, click [here](./../../users/keys/keyring.md).
:::

## Clearing data from chain

### Reset Data

Alternatively, you can **reset** the blockchain database, remove the node's address book files, and reset the `priv_validator.json` to the genesis state.

::: danger
If you are running a **validator node**, always be careful when doing `torqued unsafe-reset-all`. You should never use this command if you are not switching `chain-id`.
:::

::: danger
**IMPORTANT**: Make sure that every node has a unique `priv_validator.json`. **Do not** copy the `priv_validator.json` from an old node to multiple new nodes. Running two nodes with the same `priv_validator.json` will cause you to double sign!
:::

First, remove the outdated files and reset the data.

```bash
rm $HOME/.torqued/config/addrbook.json $HOME/.torqued/config/genesis.json
torqued tendermint unsafe-reset-all --home $HOME/.torqued
```

Your node is now in a pristine state while keeping the original `priv_validator.json` and `config.toml`. If you had any sentry nodes or full nodes setup before, your node will still try to connect to them, but may fail if they haven't also been upgraded.

### Delete Data

Data for the {{ $themeConfig.project.binary }} binary should be stored at `~/.{{ $themeConfig.project.binary }}`, respectively by default. To **delete** the existing binaries and configuration, run:

```bash
rm -rf ~/.torqued
```

To clear all data except key storage (if keyring backend chosen) and then you can rerun the full node installation commands from above to start the node again.

## Recording Transactions Per Second (TPS)

In order to get a progressive value of the transactions per second, we use Prometheus to return the values.
<!-- markdown-link-check-disable-next-line -->
The Prometheus exporter runs at address http://localhost:8877 so please add this
section to your [Prometheus installation](https://opencensus.io/codelabs/prometheus/#1) config.yaml file like this

```yaml
global:
  scrape_interval: 10s

  external_labels:
    monitor: 'torque'

scrape_configs:
  - job_name: 'torque'

    scrape_interval: 10s

    static_configs:
      - targets: ['localhost:8877']
```

and then run Prometheus like this

```shell
prometheus --config.file=prom_config.yaml
```

<!-- markdown-link-check-disable-next-line -->
and then visit the Prometheus dashboard at http://localhost:9090/ then navigate to the expression area and enter the following expression

```shell
rate(torqued_transactions_processed[1m])
```

which will show the rate of transactions processed.

## Next {hide}

Learn about running a Torque [testnet](./../testnet.md) {hide}
