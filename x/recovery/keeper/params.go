package keeper

import (
	sdk "github.com/cosmos/cosmos-sdk/types"

	"github.com/hardiksa/torque/v4/x/recovery/types"
)

// GetParams returns the total set of recovery parameters.
func (k Keeper) GetParams(ctx sdk.Context) (params types.Params) {
	k.paramstore.GetParamSet(ctx, &params)
	return params
}

// SetParams sets the recovery parameters to the param space.
func (k Keeper) SetParams(ctx sdk.Context, params types.Params) {
	k.paramstore.SetParamSet(ctx, &params)
}
