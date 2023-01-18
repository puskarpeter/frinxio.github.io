# RPC compare-config

This RPC is a combination of sync-from-network and calculate diff RPCs. 
If one of these RPCs fails the RPC will fail without any changes made.

The purpose of this RPC is to synchronize configuration from the network
devices to UniConfig nodes in the Configuration datastore of UniConfig
transaction. The RPC input contains a list of the UniConfig nodes where
the configuration should be refreshed within the network. Output of the
RPC describes the result of compare-config and matches all input nodes
with list of statements representing the diff.

## RPC Examples

### Successful Example

```bash RPC Request
curl --location --request POST 'http://127.0.0.1:8181/rests/operations/uniconfig-manager:compare-config' \
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
                    "status": "complete",
                    "created-data": [
                        {
                            "path": "/network-topology:network-topology/topology=uniconfig/node=IOSXR/frinx-uniconfig-topology:configuration/events:event/internal/assoc=test",
                            "data": "{\n  \"assoc\": [\n    {\n      \"name\": \"test\",\n      \"id\": \"vmod-org-create\",\n      \"scripts\": [\n        \"script0.sh\"\n      ],\n      \"type\": \"ipc\"\n    }\n  ]\n}"
                        }
                    ],
                    "updated-data": [
                        {
                            "path": "/network-topology:network-topology/topology=uniconfig/node=IOSXR/frinx-uniconfig-topology:configuration/oam:alarms/alarm=all",
                            "data-actual": "{\n  \"oam:destinations\": [\n    \"netconf\",\n    \"analytics\"\n  ]\n}",
                            "data-intended": "{\n  \"oam:destinations\": [\n    \"netconf\"\n  ]\n}"
                        }
                    ]
                },
                {
                    "node-id": "IOSXRN",
                    "status": "complete",
                    "created-data": [
                        {
                            "path": "/network-topology:network-topology/topology=uniconfig/node=IOSXRN/frinx-uniconfig-topology:configuration/oam:alarms",
                            "data": "{\n  \"oam:alarms\": {\n    \"alarm\": [\n      {\n        \"name\": \"all\",\n        \"destinations\": [\n          \"netconf\"\n        ]\n      }\n    ]\n  }\n}"
                        },
                        {
                            "path": "/network-topology:network-topology/topology=uniconfig/node=IOSXRN/frinx-uniconfig-topology:configuration/events:event/internal/assoc=test",
                            "data": "{\n  \"assoc\": [\n    {\n      \"name\": \"test\",\n      \"scripts\": [\n        \"script0.sh\"\n      ],\n      \"id\": \"vmod-org-create\",\n      \"type\": \"ipc\"\n    }\n  ]\n}"
                        }
                    ]
                }
            ]
        },
        "overall-status": "complete"
    }
}
```

### Successful Example

If the RPC input does not contain the target nodes, all touched nodes will be invoked.

```bash RPC Request
curl --location --request POST 'http://127.0.0.1:8181/rests/operations/uniconfig-manager:compare-config' \
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
        "node-results": {
            "node-result": [
                {
                    "node-id": "IOSXR",
                    "status": "complete",
                    "created-data": [
                        {
                            "path": "/network-topology:network-topology/topology=uniconfig/node=IOSXR/frinx-uniconfig-topology:configuration/events:event/internal/assoc=test",
                            "data": "{\n  \"assoc\": [\n    {\n      \"name\": \"test\",\n      \"id\": \"vmod-org-create\",\n      \"scripts\": [\n        \"script0.sh\"\n      ],\n      \"type\": \"ipc\"\n    }\n  ]\n}"
                        }
                    ],
                    "updated-data": [
                        {
                            "path": "/network-topology:network-topology/topology=uniconfig/node=IOSXR/frinx-uniconfig-topology:configuration/oam:alarms/alarm=all",
                            "data-actual": "{\n  \"oam:destinations\": [\n    \"netconf\",\n    \"analytics\"\n  ]\n}",
                            "data-intended": "{\n  \"oam:destinations\": [\n    \"netconf\"\n  ]\n}"
                        }
                    ]
                },
                {
                    "node-id": "IOSXRN",
                    "status": "complete",
                    "created-data": [
                        {
                            "path": "/network-topology:network-topology/topology=uniconfig/node=IOSXRN/frinx-uniconfig-topology:configuration/oam:alarms",
                            "data": "{\n  \"oam:alarms\": {\n    \"alarm\": [\n      {\n        \"name\": \"all\",\n        \"destinations\": [\n          \"netconf\"\n        ]\n      }\n    ]\n  }\n}"
                        },
                        {
                            "path": "/network-topology:network-topology/topology=uniconfig/node=IOSXRN/frinx-uniconfig-topology:configuration/events:event/internal/assoc=test",
                            "data": "{\n  \"assoc\": [\n    {\n      \"name\": \"test\",\n      \"scripts\": [\n        \"script0.sh\"\n      ],\n      \"id\": \"vmod-org-create\",\n      \"type\": \"ipc\"\n    }\n  ]\n}"
                        }
                    ]
                }
            ]
        },
        "overall-status": "complete"
    }
}
```

### Failed Example

```bash RPC Request
curl --location --request POST 'http://127.0.0.1:8181/rests/operations/uniconfig-manager:compare-config' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--data-raw '{
    "input": {
        "target-nodes": {
            "node": ["IOSXR","NOTINSTALLEDNODE"]
        }    
    }
}'
```

```bash RPC Response, Status: 200
{
    "output": {
        "node-results": {
            "node-result": [
                {
                    "node-id": "IOSXR",
                    "status": "fail"
                },
                {
                    "node-id": "NOTINSTALLEDNODE",
                    "status": "fail",
                    "error-message": "Node 'NOTINSTALLEDNODE' hasn't been installed in Uniconfig database"
                }
            ]
        },
        "overall-status": "fail"
    }
}
```

If the RPC input does not contain the target nodes and there weren't any
touched nodes, the request will result in an error.

### Failed Example

```bash RPC Request
curl --location --request POST 'http://127.0.0.1:8181/rests/operations/uniconfig-manager:compare-config' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--data-raw '{
    "input": {
        "target-nodes": {
        }    
    }
}'
```

```bash RPC Response, Status: 200
{
    "output": {
        "error-message": "There aren't any nodes specified in input RPC and there aren't any touched nodes.",
        "overall-status": "fail"
    }
}
```