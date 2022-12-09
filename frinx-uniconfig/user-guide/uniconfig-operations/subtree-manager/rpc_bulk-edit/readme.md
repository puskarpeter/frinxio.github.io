# RPC bulk-edit

The bulk-edit operation can be used to modify multiple configuration subtrees under multiple target nodes
from the 'uniconfig', 'templates' or 'unistore' topology (the same list of modifications are applied to all listed
target nodes). The bulk-edit operation is executed atomically - either all modifications are applied on all target nodes
successfully, or the operation fails and the configuration is not touched in the UniConfig transaction. This RPC also benefits
from parallel processing of changes per target node.

![RPC bulk-edit](Execution_of_bulk_edit_RPC.svg)

## RPC input

RPC input specifies a list of target nodes and a list of modifications that must be applied under target nodes:

Description of input fields:

* **topology-id** (mandatory): Identifier for the topology which contains all target nodes.
  Currently supported topologies: uniconfig, templates, unistore.
* **node-id** (optional): List of target nodes identifiers residing in the specified topology. If this field is not
  specified or is empty, RPC is executed on all available nodes in the specified topology.
* **edit** (mandatory with at least 1 entry): List of modifications. Each modification is uniquely identified
  by the 'path' key. Modifications are applied in the preserved user-defined order.

Description of fields in the edit entry:

* **path** (mandatory): Path encoded using the RFC-8040 format. Specified as relative path to root
  'configuration' container. If this leaf contains a single character '/', the path points to the whole configuration.
  If this path contains a list node without key, the operation is applied to all list node elements.
* **operation** (mandatory): Operation that must be executed on the specified path. Supported operations
  are 'merge', 'replace', and 'remove'. Operations 'merge' and 'replace' requires to also specify input 'data'.
* **data** (optional): Content of the replaced or merged data without wrapping parent element
  (the last element of the path is not declared in the 'data', see examples on how to correctly specify content 
  of this leaf in different use-cases).

Supported operations:

* **merge**: Supplied value is merged with the target data node.
* **replace**: Supplied value is used to replace the target data node.
* **remove**: Delete target node if it exists.

## RPC output

RPC output contains the global status of the executed operation and per-node status.

Description of output fields:

* **overall-status**: Status of operation. If RPC execution fails on at least one of the target nodes,
  the overall status is set to 'fail'. Otherwise, status is set to 'complete'.
* **error-message**: "Reason for the failure. Used if there is a structural error 
  in the RPC input that does not relate to one specific target node."
* **node-result**: Results of RPC execution divided per target node ('node-id' is the key of the list).

Description of fields in the node-result entry:

* **node-id**: Identifier for the target node.
* **status**: Status of bulk-edit operation on this node. This value is set to 'complete' only if all modifications have
  been successfully written into UniConfig transaction (including other nodes). Otherwise, the value is set to 'fail'.
* **error-message**: Reason for the failure. This field appears in the output only if RPC execution failed
  on this target node.
* **error-type**: Categorized error type.

## RPC examples

### Successful example

The following request demonstrates the application of six (6) modifications to four (4) templates:

1. Replace the value of the 'description' leaf.
2. Remove the 'snmp' container.
3. Replace the whole 'ssh' container.
4. Merge the configuration of the 'routing-protocol' list entry.
5. Merge the whole 'tree' list with the specified multiple list entries.
6. Replace the leaf-list 'services' with the provided array of strings.

```bash RPC request
curl --location --request POST 'http://127.0.0.1:8181/rests/operations/subtree-manager:bulk-edit' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--header 'Cookie: UNICONFIGTXID=7bb3fbdf-23b0-488e-8d59-8d0b2757da73' \
--data-raw '{
    "input": {
        "topology-id": "templates",
        "node-id": [
            "tpl_1",
            "tpl_2",
            "tpl_3",
            "tpl_4"
        ],
        "edit": [
            {
                "path": "/sfc:service-node-groups/service-node-group/type",
                "operation": "replace",
                "data": "test"
            },
            {
                "path": "/groups/group=test/description",
                "operation": "replace",
                "data": "test"
            },
            {
                "path": "/snmp/config",
                "operation": "remove"
            },
            {
                "path": "/system/netconf/ssh",
                "operation": "replace",
                "data": {
                    "ip": "10.10.10.10",
                    "enabled": false,
                    "port": 2243
                }
            },
            {
                "path": "/routing-protocol/routing-protocol=test",
                "operation": "merge",
                "data": {
                    "@": {
                        "template-tags:operation": "create"
                    },
                    "name": "test"
                }
            },
            {
                "path": "/snmp/view=internet/tree",
                "operation": "merge",
                "data": [
                    {
                        "oid": "1.4",
                        "included": true
                    },
                    {
                        "oid": "1.5",
                        "included": false
                    }
                ]
            },
            {
                "path": "/router/services",
                "operation": "replace",
                "data": [
                    "dhcp",
                    "rarp"
                ]
            }
        ]
    }
}'
```

The response contains the overall status 'complete' and per-node status 'complete' - all modifications have been successfully
written into the UniConfig transaction.

```json RPC response
{
    "output": {
        "overall-status": "complete",
        "node-result": [
            {
                "node-id": "tpl_1",
                "status": "complete"
            },
            {
                "node-id": "tpl_2",
                "status": "complete"
            },
            {
                "node-id": "tpl_3",
                "status": "complete"
            },
            {
                "node-id": "tpl_4",
                "status": "complete"
            }
        ]
    }
}
```

### Failed example

The following example demonstrates the execution of a bulk-edit operation that fails on parsing one of the paths
using YANG schemas of the device 'dev02'.


```bash RPC request
curl --location --request POST 'http://127.0.0.1:8181/rests/operations/subtree-manager:bulk-edit' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--header 'Cookie: UNICONFIGTXID=7bb3fbdf-23b0-488e-8d59-8d0b2757da73' \
--data-raw '{
    "input": {
        "node-id": [
            "dev01",
            "dev02"
        ],
        "topology-id": "uniconfig",
        "edit": [
            {
                "path": "/dhcp/profile=test-profile",
                "operation": "replace",
                "data": {
                    "name": "test-profile",
                    "description": "test"
                }
            },
            {
                "path": "/settings",
                "operation": "remove"
            }
        ]
    }
}'
```

The RPC response contains the overall status 'fail'. There is one error message in the result of 'dev02'. Note that the 'dev01'
result also contains the 'fail' status, as modifications have not been written to this node since another node ('dev02') failed
during execution of the operation.

```json RPC response
{
    "output": {
        "overall-status": "fail",
        "node-result": [
            {
                "node-id": "dev01",
                "status": "fail",
                "error-type": "uniconfig-error"
            },
            {
                "node-id": "dev02",
                "status": "fail",
                "error-message": "Failed to parse path: Could not parse path 'network-topology:network-topology/topology=uniconfig/node=dev02/frinx-uniconfig-topology:configuration/dhcp/profile=test-profile'. Offset: '108': Reason: List entry '(test-ns?revision=2018-09-12)dhcp' requires key or value predicate to be present",
                "error-type": "uniconfig-error"
            }
        ]
    }
}
```