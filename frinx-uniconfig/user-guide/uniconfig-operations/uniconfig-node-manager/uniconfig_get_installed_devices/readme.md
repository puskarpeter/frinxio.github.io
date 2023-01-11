# RPC get-installed-nodes

This RPC gets all the installed devices from a selected topology. 
If a topology is not specified, the output may contain devices from 
mulitple topologies (CLI, NETCONF, gNMI).

## RPC Examples

### Successful example

RPC does not have any input and device 'testDevice' is installed in the NETCONF topology.

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

RPC input contains CLI topology in the input, but no device in CLI topology is installed.

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
