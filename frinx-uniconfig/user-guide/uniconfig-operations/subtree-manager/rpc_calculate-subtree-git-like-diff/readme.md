# RPC calculate-subtree-git-like-diff

This RPC creates a diff between the source topology subtrees and target topology subtrees.
Supported features:
* Comparison of subtrees under same network-topology node.
* Comparison of subtrees between different network-topology nodes that use same YANG schemas.
* Comparison of subtrees with different revisions of YANGs schema that are syntactically compatible
  (for example, different software versions of devices).

RPC input contains data-tree paths ('source-path' and 'target-path') and data locations
('source-datastore' and 'target-datastore').
Data location is the enumeration of two possible values, 'OPERATIONAL' and 'CONFIGURATION'.
The default value of 'source-datastore' is 'OPERATIONAL' and
default value of 'target-datastore' is 'CONFIGURATION'.

RPC output contains differences between source and target subtrees formatted in a git-like style.
The changes are grouped by root entities in the configuration.

![RPC calculate-subtree-git-like-diff](RPC_calculate-subtree-git-like-diff-RPC_calculate_subtree_git_like_diff.svg)

## RPC Examples

### Successful example: Computed difference

RPC calculate-subtree-git-like-diff input includes the path to two interfaces
on different nodes. Both data locations are placed in the
CONFIGURATION datastore. Output contains a list of all the changes.
Multiple changes that occur under the same root element are merged together.

```bash RPC Request
curl --location --request POST 'http://localhost:8181/rests/operations/uniconfig-manager:calculate-subtree-git-like-diff' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--data-raw '{
    "input" : {
        "source-path": ["/network-topology:network-topology/network-topology:topology=uniconfig/network-topology:node=XR5/frinx-uniconfig-topology:configuration/frinx-openconfig-interfaces:interfaces/frinx-openconfig-interfaces:interface=MgmtEth0%2F0%2FCPU0%2F0"],
        "target-path": ["/network-topology:network-topology/network-topology:topology=uniconfig/network-topology:node=XR6/frinx-uniconfig-topology:configuration/frinx-openconfig-interfaces:interfaces/frinx-openconfig-interfaces:interface=MgmtEth0%2F0%2FCPU0%2F0"],
        "source-datastore": "CONFIGURATION",
        "target-datastore": "CONFIGURATION"
    }
}'
```

```json RPC Response, Status: 200
{
    "output": {
        "changes": [
            "  {\n    \"frinx-openconfig-interfaces:interfaces\": {\n      \"interface\": [\n        {\n          \"key\":\"MgmtEth0/0/CPU0/0\",\n          \"subinterfaces\": {\n            \"subinterface\": [\n              {\n                \"key\":\"0\",\n                \"frinx-openconfig-if-ip:ipv4\": {\n                  \"addresses\": {\n                    \"address\": [\n-                     {\n-                       \"ip\":\"192.168.1.212\",\n-                       \"config\": {\n-                         \"prefix-length\":\"24\",\n-                         \"ip\":\"192.168.1.212\"\n-                       }\n-                     },\n+                     {\n+                       \"ip\":\"192.168.1.214\",\n+                       \"config\": {\n+                         \"prefix-length\":\"27\",\n+                         \"ip\":\"192.168.1.214\"\n+                       }\n+                     }\n                    ]\n                  }\n                },\n                \"config\": {\n                  \"enabled\": {\n                    \"actual\": {\n                      \"frinx-openconfig-interfaces:enabled\":\"false\"\n                    },\n                    \"intended\": {\n                      \"frinx-openconfig-interfaces:enabled\":\"true\"\n                    }\n                  },\n-                 \"frinx-openconfig-interfaces:index\":\"15\",\n+                 \"frinx-openconfig-interfaces:index\":\"0\"\n                }\n              }\n            ]\n          },\n          \"config\": {\n-           \"frinx-openconfig-interfaces:enabled\":\"false\",\n+           \"frinx-openconfig-interfaces:enabled\":\"true\"\n          }\n        }\n      ]\n    }\n  }\n"
        ]
    }
}
```

### Successful example: No difference

The following output demonstrates a situation with no changes
between specified subtrees.

```bash RPC Request
curl --location --request POST 'http://localhost:8181/rests/operations/uniconfig-manager:calculate-subtree-git-like-diff' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--data-raw '{
    "input" : {
        "source-path": ["/network-topology:network-topology/network-topology:topology=uniconfig/network-topology:node=XR5/frinx-uniconfig-topology:configuration/frinx-openconfig-interfaces:interfaces/frinx-openconfig-interfaces:interface=GigabitEthernet0%2F0%2F0%2F0"],
        "target-path": ["/network-topology:network-topology/network-topology:topology=uniconfig/network-topology:node=XR6/frinx-uniconfig-topology:configuration/frinx-openconfig-interfaces:interfaces/frinx-openconfig-interfaces:interface=GigabitEthernet0%2F0%2F0%2F0"],
        "source-datastore": "CONFIGURATION",
        "target-datastore": "CONFIGURATION"
    }
}'
```

```json RPC Response, Status: 200
{
    "output": {
    }
}
```

### Failed example: Missing mandatory field

RPC input does not contain the mandatory target path.

```bash RPC Request
curl --location --request POST 'http://localhost:8181/rests/operations/uniconfig-manager:calculate-subtree-git-like-diff' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--data-raw '{
    "input" : {
        "source-path": ["/network-topology:network-topology/network-topology:topology=uniconfig/network-topology:node=R1/frinx-uniconfig-topology:configuration/frinx-openconfig-interfaces:interfaces/frinx-openconfig-interfaces:interface=GigabitEthernet0%2F0%2F0%2F0"],
        "source-datastore": "CONFIGURATION",
        "target-datastore": "CONFIGURATION"
    }
}'
```

```json RPC Response, Status: 400
{
  "errors": {
    "error": [
      {
        "error-message": "Field target-path is not specified in input request",
        "error-tag": "invalid-value",
        "error-type": "application"
      }
    ]
  }
}
```
    
