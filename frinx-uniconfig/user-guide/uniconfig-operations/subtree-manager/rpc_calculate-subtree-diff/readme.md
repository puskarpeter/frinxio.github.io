# RPC calculate-subtree-diff

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

RPC output contains a list of differences between source and target subtrees.

![RPC calculate-subtree-dif](RPC_calculate_subtree_diff-RPC_calculate_subtree_diff.svg)

## RPC Examples

### Successful example: Computed difference

RPC calculate-subtree-diff input has a path to two different testtool
devices with different YANG schemas. Output contains a list of statements
representing the diff.

```json Node testtool with schema test-module
{
    "root": {
        "simple-root": {
            "leaf-a": "leafA",
            "leaf-b": "EDITED",
            "ll": [
                "str1",
                "str2",
                "str3"
            ],
            "nested": {
                "sample-y": false
            }
        },
        "list-root": {
            "branch-ab": 9999,
            "top-list": [
                {
                    "key-1": "ka",
                    "key-2": "kb",
                    "next-data": {
                        "switch-1": [
                            null
                        ],
                        "switch-2": [
                            null
                        ]
                    },
                    "nested-list": [
                        {
                            "identifier": "f1",
                            "foo": 1
                        },
                        {
                            "identifier": "f2",
                            "foo": 10
                        },
                        {
                            "identifier": "f3",
                            "foo": 20
                        }
                    ]
                },
                {
                    "key-1": "kb",
                    "key-2": "ka",
                    "next-data": {
                        "switch-1": [
                            null
                        ]
                    },
                    "nested-list": [
                        {
                            "identifier": "e1",
                            "foo": 1
                        },
                        {
                            "identifier": "e2",
                            "foo": 2
                        },
                        {
                            "identifier": "e3",
                            "foo": 3
                        }
                    ]
                },
                {
                    "key-1": "kc",
                    "key-2": "ke",
                    "next-data": {
                        "switch-2": [
                            null
                        ]
                    },
                    "nested-list": [
                        {
                            "identifier": "q1",
                            "foo": 13
                        },
                        {
                            "identifier": "q2",
                            "foo": 14
                        },
                        {
                            "identifier": "q3",
                            "foo": 15
                        }
                    ]
                }
            ]
        },
        "choice-root": {
            "cb": [
                {
                    "key-cb": "f1",
                    "next-bit": "asdfgh"
                },
                {
                    "key-cb": "f2",
                    "next-bit": "qwertz"
                },
                {
                    "key-cb": "f3",
                    "next-bit": "yxcvb"
                },
                {
                    "key-cb": "f4",
                    "next-bit": "poiuzz"
                }
            ]
        },
        "augmented-root": {
            "aug-c": {
                "original-leaf": [
                    null
                ],
                "test-augment:list-1": [
                    {
                        "leaf-x": "x1",
                        "leaf-y": "x1"
                    },
                    {
                        "leaf-x": "x2",
                        "leaf-y": "x1"
                    },
                    {
                        "leaf-x": "x3",
                        "leaf-y": "x1"
                    }
                ]
            },
            "aug-l": [
                {
                    "my-key": "k1",
                    "test-augment:abc": {
                        "abc": false
                    }
                },
                {
                    "my-key": "k2",
                    "test-augment:abc": {
                        "abc": true
                    }
                },
                {
                    "my-key": "k3",
                    "test-augment:abc": {
                        "abc": false
                    }
                }
            ]
        }
    }
}
```

```json Node testtool2 with schema test-module-mod
{
    "root": {
        "simple-root": {
            "leaf-a": "leafA",
            "leaf-b": "leafB",
            "ll": [
                "str1",
                "str2",
                "EDITED"
            ],
            "nested": {
                "sample-y": false
            }
        },
        "list-root": {
            "branch-ab": 5,
            "top-list": [
                {
                    "key-1": "ka",
                    "key-2": "kb",
                    "next-data": {
                        "switch-1": [
                            null
                        ],
                        "switch-2": [
                            null
                        ]
                    },
                    "nested-list": [
                        {
                            "identifier": "f1",
                            "foo": 1
                        },
                        {
                            "identifier": "f2",
                            "foo": 10
                        },
                        {
                            "identifier": "f3",
                            "foo": 20
                        }
                    ]
                },
                {
                    "key-1": "kb",
                    "key-2": "ka",
                    "next-data": {
                        "switch-1": [
                            null
                        ]
                    },
                    "nested-list": [
                        {
                            "identifier": "e1",
                            "foo": 1
                        },
                        {
                            "identifier": "e2",
                            "foo": 2
                        },
                        {
                            "identifier": "e3",
                            "foo": 3
                        }
                    ]
                },
                {
                    "key-1": "kc",
                    "key-2": "EDITED",
                    "next-data": {
                        "switch-2": [
                            null
                        ]
                    },
                    "nested-list": [
                        {
                            "identifier": "q1",
                            "foo": 13
                        },
                        {
                            "identifier": "q2",
                            "foo": 14
                        },
                        {
                            "identifier": "q3",
                            "foo": 15
                        }
                    ]
                }
            ]
        },
        "choice-root": {
            "cb": [
                {
                    "key-cb": "f1",
                    "next-bit": "asdfgh"
                },
                {
                    "key-cb": "f2",
                    "next-bit": "qwertz"
                },
                {
                    "key-cb": "f3",
                    "next-bit": "yxcvb"
                },
                {
                    "key-cb": "f4",
                    "next-bit": "poiuzz"
                }
            ]
        },
        "augmented-root": {
            "aug-c": {
                "original-leaf": [
                    null
                ],
                "test-augment:list-1": [
                    {
                        "leaf-x": "x1",
                        "leaf-y": "x1"
                    },
                    {
                        "leaf-x": "EDITED",
                        "leaf-y": "x1"
                    },
                    {
                        "leaf-x": "x3",
                        "leaf-y": "x1"
                    }
                ]
            },
            "aug-l": [
                {
                    "my-key": "k1",
                    "test-augment:abc": {
                        "abc": false
                    }
                },
                {
                    "my-key": "EDITED",
                    "test-augment:abc": {
                        "abc": true
                    }
                },
                {
                    "my-key": "k3",
                    "test-augment:abc": {
                        "abc": false
                    }
                }
            ]
        }
    }
}
```

```bash RPC Request
curl --location --request POST 'http://localhost:8181/rests/operations/subtree-manager:calculate-subtree-diff' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--data-raw '{
    "input": {
        "source-path": "/network-topology:network-topology/topology=uniconfig/node=testtool/configuration/test-module:root",
        "source-datastore": "OPERATIONAL",
        "target-path": "/network-topology:network-topology/topology=uniconfig/node=testtool2/configuration/test-module-mod:root",
        "target-datastore": "OPERATIONAL"
    }
}'
```

```json RPC Response, Status: 200
{
    "output": {
        "updated-data": [
            {
                "path-intended": "/network-topology:network-topology/topology=uniconfig/node=testtool/frinx-uniconfig-topology:configuration/test-module:root/list-root/branch-ab",
                "path-actual": "/network-topology:network-topology/topology=uniconfig/node=testtool2/frinx-uniconfig-topology:configuration/test-module-mod:root/list-root/branch-ab",
                "data-actual": {
                  "test-module-mod:branch-ab": 5
                },
                "data-intended": {
                  "test-module:branch-ab": 9999
                }
            },
            {
                "path-intended": "/network-topology:network-topology/topology=uniconfig/node=testtool/frinx-uniconfig-topology:configuration/test-module:root/simple-root",
                "path-actual": "/network-topology:network-topology/topology=uniconfig/node=testtool2/frinx-uniconfig-topology:configuration/test-module-mod:root/simple-root",
                "data-actual": {
                  "test-module-mod:ll": [
                    "EDITED",
                    "str1",
                    "str2"
                  ]
                },
                "data-intended": {
                  "test-module:ll": [
                    "str3",
                    "str2",
                    "str1"
                  ]
                }
            },
            {
                "path-intended": "/network-topology:network-topology/topology=uniconfig/node=testtool/frinx-uniconfig-topology:configuration/test-module:root/simple-root/leaf-b",
                "path-actual": "/network-topology:network-topology/topology=uniconfig/node=testtool2/frinx-uniconfig-topology:configuration/test-module-mod:root/simple-root/leaf-b",
                "data-actual": {
                  "test-module-mod:leaf-b": "leafB"
                },
                "data-intended": {
                  "test-module:leaf-b": "EDITED"
                }
            }
        ],
        "created-data": [
            {
                "path": "/network-topology:network-topology/topology=uniconfig/node=testtool2/frinx-uniconfig-topology:configuration/test-module-mod:root/augmented-root/aug-l=EDITED",
                "data": {
                  "aug-l": [
                    {
                      "my-key": "EDITED",
                      "test-augment-mod:abc": {
                        "abc": true
                      }
                    }
                  ]
                }
            },
            {
                "path": "/network-topology:network-topology/topology=uniconfig/node=testtool2/frinx-uniconfig-topology:configuration/test-module-mod:root/augmented-root/aug-c/test-augment-mod:list-1=EDITED",
                "data": {
                  "list-1": [
                    {
                      "leaf-x": "EDITED",
                      "leaf-y": "x1"
                    }
                  ]
                }
            },
            {
                "path": "/network-topology:network-topology/topology=uniconfig/node=testtool2/frinx-uniconfig-topology:configuration/test-module-mod:root/list-root/top-list=kc,EDITED",
                "data": {
                  "top-list": [
                    {
                      "key-1": "kc",
                      "key-2": "EDITED",
                      "nested-list": [
                        {
                          "identifier": "q2",
                          "foo": 14
                        },
                        {
                          "identifier": "q1",
                          "foo": 13
                        },
                        {
                          "identifier": "q3",
                          "foo": 15
                        }
                      ],
                      "next-data": {
                        "switch-2": [
                          null
                        ]
                      }
                    }
                  ]
                }
            }
        ],
        "deleted-data": [
            {
                "path": "/network-topology:network-topology/topology=uniconfig/node=testtool/frinx-uniconfig-topology:configuration/test-module:root/list-root/top-list=kc,ke",
                "data": {
                  "top-list": [
                    {
                      "key-1": "kc",
                      "key-2": "ke",
                      "nested-list": [
                        {
                          "identifier": "q2",
                          "foo": 14
                        },
                        {
                          "identifier": "q1",
                          "foo": 13
                        },
                        {
                          "identifier": "q3",
                          "foo": 15
                        }
                      ],
                      "next-data": {
                        "switch-2": [
                          null
                        ]
                      }
                    }
                  ]
                }
            },
            {
                "path": "/network-topology:network-topology/topology=uniconfig/node=testtool/frinx-uniconfig-topology:configuration/test-module:root/augmented-root/aug-c/test-augment:list-1=x2",
                "data": {
                  "list-1": [
                    {
                      "leaf-x": "x2",
                      "leaf-y": "x1"
                    }
                  ]
                }
            },
            {
                "path": "/network-topology:network-topology/topology=uniconfig/node=testtool/frinx-uniconfig-topology:configuration/test-module:root/augmented-root/aug-l=k2",
                "data": {
                  "aug-l": [
                    {
                      "my-key": "k2",
                      "test-augment:abc": {
                        "abc": true
                      }
                    }
                  ]
                }
            }
        ]
    }
}
```

### Successful example: No difference

The following output demonstrates a situation with no changes
between specified subtrees.

```bash RPC Request
curl --location --request POST 'http://localhost:8181/rests/operations/uniconfig-manager:calculate-subtree-diff' \
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

### Failed example: Invalid value in input field

RPC calculate-subtree-diff has an improperly defined datastore (AAA)
within the input. Output describes the Allowed values [CONFIGURATION,
OPERATIONAL].

```bash RPC Request
curl --location --request POST 'http://localhost:8181/rests/operations/subtree-manager:calculate-subtree-diff' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--data-raw '{
    "input": {
        "source-path": "/network-topology:network-topology/topology=uniconfig/node=testtool/configuration/test-module:root",
        "source-datastore": "AAA",
        "target-path": "/network-topology:network-topology/topology=uniconfig/node=testtool2/configuration/test-module-mod:root",
        "target-datastore": "OPERATIONAL"
    }
}'
```

```json RPC Response, Status: 400
{
    "errors": {
        "error": [
            {
                "error-type": "protocol",
                "error-message": "Error parsing input: Invalid value 'AAA' for enum type. Allowed values are: [CONFIGURATION, OPERATIONAL]",
                "error-tag": "malformed-message",
                "error-info": "Invalid value 'AAA' for enum type. Allowed values are: [CONFIGURATION, OPERATIONAL]"
            }
        ]
    }
}
```

### Failed example: Missing mandatory field

RPC input does not contain the mandatory source path.

```bash RPC Request
curl --location --request POST 'http://localhost:8181/rests/operations/subtree-manager:calculate-subtree-diff' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--data-raw '{
    "input": {
        "target-path": "/network-topology:network-topology/topology=uniconfig/node=testtool2/configuration/test-module-mod:root",
        "target-datastore": "OPERATIONAL"
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
