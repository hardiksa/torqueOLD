package client

import (
	govclient "github.com/cosmos/cosmos-sdk/x/gov/client"

	"github.com/hardiksa/torque/v4/x/incentives/client/cli"
	"github.com/hardiksa/torque/v4/x/incentives/client/rest"
)

var (
	RegisterIncentiveProposalHandler = govclient.NewProposalHandler(cli.NewRegisterIncentiveProposalCmd, rest.RegisterIncentiveProposalRESTHandler)
	CancelIncentiveProposalHandler   = govclient.NewProposalHandler(cli.NewCancelIncentiveProposalCmd, rest.CancelIncentiveProposalRequestRESTHandler)
)
