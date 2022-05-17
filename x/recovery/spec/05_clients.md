<!--
order: 5
-->

# Clients

A user can query the `x/recovery` module using the CLI, gRPC or REST.

## CLI

Find below a list of `torqued` commands added with the `x/recovery` module. You can obtain the full list by using the `torqued` -h command.

### Queries

The query commands allow users to query Recovery state.

**`params`**
Allows users to query the module parameters.

```bash
torqued query recovery params [flags]
```

## gRPC

### Queries

| Verb   |              Method              |           Description |
| :----- | :------------------------------- | :-------------------- |
| `gRPC` | `torque.recovery.v1.Query/Params` | `Get Recovery params` |
| `GET`  |   `/torque/recovery/v1/params`    | `Get Recovery params` |
