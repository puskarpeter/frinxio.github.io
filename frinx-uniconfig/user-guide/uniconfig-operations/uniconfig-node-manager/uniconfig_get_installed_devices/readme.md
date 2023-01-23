# RPC get-installed-nodes

This RPC returns all installed devices from a selected topology. 
If no topology is specified, the output may contain devices from 
multiple topologies (CLI, NETCONF, gNMI).

## RPC Examples

### Successful example

The RPC has no input and a device called 'testDevice' is installed in the NETCONF topology.

```bash RPC Request
curl --location --request POST 'http://localhost:8181/rests/operations/connection-manager:get-installed-nodes' \
--header 'Authorization: Basic YWRtaW46YWRtaW4=' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json'
```

```json RPC Response, Status: 200
{
  "output": {
    "nodes": [
      "testDevice"
    ]
  }
}
```

### Successful example

The RPC input contains the CLI topology, but no devices are installed in the topology.

```bash RPC Request
curl --location --request POST 'http://localhost:8181/rests/operations/connection-manager:get-installed-nodes' \
--header 'Authorization: Basic YWRtaW46YWRtaW4=' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--data-raw '{
    "input": {
        "mount-type": "cli"
    }
}'
```

```json RPC Response, Status: 200
{
  "output": {}
}
```
