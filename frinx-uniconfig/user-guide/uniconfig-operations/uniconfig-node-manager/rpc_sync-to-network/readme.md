# RPC sync-to-network

This RPC is a combination of sync-from-network and commit RPCs. If one of these RPCs fails
the RPC will fail without any changes made.

The purpose of this RPC is to synchronize configuration from the
UniConfig nodes in the Configuration datastore of UniConfig
transaction to network devices. The RPC input contains a list of the UniConfig nodes
which are to be updated on a network device. Output of the
RPC describes the result of sync-to-network and matches all input
nodes. Calling RPC with empty list of target nodes results in syncing
configuration of all nodes that have been modified in the UniConfig
transaction. If one node failed for any reason, the RPC will fail
entirely.

It is necessary for admin-state of UniConfig nodes, specified in the input,
to be set to "unlocked".

## RPC Examples

### Successful Example

RPC input contains nodes which are to be updated on the corresponding network device.

```bash RPC Request
curl --location --request POST 'http://localhost:8181/rests/operations/uniconfig-manager:sync-to-network' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--data-raw '{
    "input": {
        "target-nodes": {
            "node": ["IOSXR","IOSXRN"]
        }
    }
}'
```

```json RPC Response, Status: 200
{
    "output": {
        "node-results": {
            "node-result": [
                {
                    "node-id": "IOSXRN",
                    "status": "complete"
                },
                {
                    "node-id": "IOSXR",
                    "status": "complete"
                }
            ]
        },
        "overall-status": "complete"
    }
}
```

### Failed Example

If the RPC input does not contain the target nodes and there weren't any
touched nodes, the request will result in an error.

```bash RPC Request
curl --location --request POST 'http://localhost:8181/rests/operations/uniconfig-manager:sync-to-network' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--data-raw '{
    "input": {
        "target-nodes": {
        }
    }
}'
```

```json RPC Response, Status: 200
{
    "output": {
        "error-message": "There aren't any nodes specified in input RPC and there aren't any touched nodes.",
        "overall-status": "fail"
    }
}
```

### Failed Example

If one or more input nodes are not set to admin-state 'unlocked'
the request will result in an error pointing out nodes with 
the wrong admin-state.

```bash RPC Request
curl --location --request POST 'http://localhost:8181/rests/operations/uniconfig-manager:sync-to-network' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--data-raw '{
    "input": {
        "target-nodes": {
            "node": ["IOSXR","IOSXRN"]
        }
    }
}'
```

```json RPC Response, Status: 200
{
    "output": {
        "node-results": {
            "node-result": [
                {
                    "node-id": "IOSXR",
                    "status": "fail",
                    "error-message": "Node is currently in admin-state 'SouthboundLocked'.",
                    "error-type": "device-processing-error"
                },
                {
                    "node-id": "IOSXRN",
                    "status": "fail",
                    "error-message": "Node is currently in admin-state 'Locked'.",
                    "error-type": "device-processing-error"
                }
            ]
        },
        "overall-status": "fail"
    }
}
```

### Failed Example

RPC input contains only one node with bad admin-state.

```bash RPC Request
curl --location --request POST 'http://localhost:8181/rests/operations/uniconfig-manager:sync-to-network' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--data-raw '{
    "input": {
        "target-nodes": {
            "node": ["IOSXR","IOSXRN"]
        }
    }
}'
```

```json RPC Response, Status: 200
{
    "output": {
        "node-results": {
            "node-result": [
                {
                    "node-id": "IOSXR",
                    "status": "fail",
                    "error-type": "device-processing-error"
                },
                {
                    "node-id": "IOSXRN",
                    "status": "fail",
                    "error-message": "Node is currently in admin-state 'SouthboundLocked'.",
                    "error-type": "device-processing-error"
                }
            ]
        },
        "overall-status": "fail"
    }
}
```