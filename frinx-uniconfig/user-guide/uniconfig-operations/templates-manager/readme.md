# Templates Manager

## Overview

Templates can be used for reusing of some configuration and afterwards
easier application of this configuration into target UniConfig nodes.

Basic properties of templates as they are implemented in UniConfig:

- All templates are stored under 'templates' topology and each
    template is represented by separate 'node' list entry.
- Whole template configuration is placed under
    'frinx-uniconfig-topology:configuration' container in the
    Configuration datastore. Because of this, configuration of template
    can be accessed and modified in the same way like modification of
    UniConfig node.
- Templates are validated against single schema context. Schema
    context, against which validation is enabled, is selected at
    creation of template using 'uniconfig-schema-repository' query
    parameter. Value of the query parameter defines name of the schema
    repository that is placed under UniConfig distribution in form of
    the directory.

Currently implemented template features:

- **Variables** - They are used for parametrisation of templates.
- **Tags** - Tags can be used for selection of an operation that
    should be applied for the specific subtree at application of
    template to UniConfig node.

!!!
Schema validation of leaves and leaf-lists is adjusted, so it can
accept both string with variables and original YANG type.
!!!

## Latest-schema

Latest-schema defines name of the schema repository of which built schema context is used for template validation.
Latest-schema is used only if there is not 'uniconfig-schema-repository' query parameter when creating template.
If 'uniconfig-schema-repository' query parameter is defined, latest-schema is ignored.

### Configuration of the latest-schema

Latest-schema can be set using PUT request. It will be placed in Config datastore. Name of directory has to point
to existing schema repository that is placed under UniConfig distribution.

```bash Set the latest schema
curl --location --request PUT 'http://localhost:8181/rests/data/schema-settings:schema-settings/latest-schema' \
--header 'Content-type: application/json' \
--data-raw '{
    {
        "latest-schema" : "schemas-1"
    }
}'
```

```text PUT response
Status: 201
```

GET request can be used for check if latest-schema is placed in config datastore.

```bash Read the latest schema
curl --location --request GET 'http://localhost:8181/rests/data/schema-settings:schema-settings/latest-schema' \
--header 'Accept: application/json'
```

```json GET response
{
    "latest-schema" : "schemas-1"
}
```

### Auto-upgrading of the latest-schema

Latest-schema can be automatically upgraded by UniConfig after installation of new YANG repository. YANG repository
is installed after deploying of new type of NETCONF/GRPC device or after manual invocation of RPC for loading
of new YANG repository from directory.

In order to enable auto-upgrading process, 'latestSchemaReferenceModuleName' must be specified in the
'config/lighty-uniconfig-config.json' file:

```json settings
    "templates": {
        "enabled": false,
        "latestSchemaReferenceModuleName": "system"
    }
```

After new YANG repository is installed, then UniConfig will look for revision of module
'latestSchemaReferenceModuleName' in the repository. If found revision is more recent than the last cached
revision, UniConfig will automatically write identifier of the fresh repository into 'latest-schema' configuration.
Afterwards, 'latest-schema' is used by UniConfig the same way as it would be written manually via RESTCONF.

## Variables

Using variables it is possible to parametrise values in the template.
Structural parametrisation is not currently supported.

Properties:

- Format of the variable: '{\$variable-id}'.
- Variables can be set to each leaf and leaf-list in the template.
- Single leaf or leaf-list may contain multiple variables.
- Key of the list can also contain variable.
- Variables are substituted by provided values at the application of
    template to UniConfig node.
- It is possible to escape characters of the variable pattern ('\$',
    '{', '}'), so they will be interpreted as value and not part of the
    variable.
- Variable identifier may contain any UTF-8 characters. Characters
    '\$', '{', '}' must be escaped, if they are part of the variable
    identifier.

### Examples with variables

**A. Leaf with one variable**

- The following example shows 2 leaves with 2 variables: 'var-1' and
    'var-2'.

```
{
  "leaf-a": "{$var-1}",
  "leaf-b": "{$var-2}"
}
```

Application of values '10' and 'false' to 'var-1', and 'var-2'. Leaf
'leaf-a' has 'int32' type and 'leaf-b' has 'boolean' type.

```
{
  "leaf-a": 10,
  "leaf-b": false
}
```

**B. Leaf with multiple variables**

- Leaf 'leaf-a' contains 2 variables and surrounding text that is not
    part of any variable.
- Leaf 'leaf-b' contains 2 variable without additional text -
    substituted values of these variables are concatenated at
    application of template.

```
{
  "leaf-a": "custom {$var-x} text {$var-y}",
  "leaf-b": "{$var-1}{$var-2}"
}
```

Application of values - 'var-x': 'next', 'var-y': '7', 'var-1': '10',
'var-2': '9'. Leaf 'leaf-a' has 'string' type and 'leaf-b' has 'int32'
type.

```
{
  "leaf-a": "custom next text 7",
  "leaf-b": 109
}
```

**C. Leaf-list with one variable**

- Leaf-list 'leaf-list-a' contains variable with identifier 'var-x'.
- This variable can be substituted by one or multiple values. If
    multiple values are provided in the apply-template RPC, they are
    'unwrapped' to the leaf-list in form of next leaf-list entries.

```
{
  "leaf-list-a": [
    "{$var-x}"
  ]
}
```

Substitution of 'var-x' with numbers '10', '20', '30' results in
('int32' type):

```
{
  "leaf-list-a": [
    10, 20, 30
  ]
}
```

**D. Leaf-list with multiple variables**

- Leaf-list 'leaf-list-a' contains 2 variables with identifiers
    'var-a' and 'var-2'. String "str3" represents constant value.
- It is possible to substitute both variables with one or multiple
    variables.

```
{
  "leaf-list-a": [
    "{$var-a}",
    "str3",
    "{$var-b}"
  ]
}
```

Substitution of 'var-a' with texts 'str1', 'str2' and 'var-b' with
'str4' results in ('string' type):

```
{
  "leaf-list-a": [
    "str1",
    "str2",
    "str3",
    "str4"
  ]
}
```

!!!
If leaf-list is marked as "ordered-by user", then the order of
leaf-list elements is preserved during substitution process.
!!!

**E. Leaf-list with entry that contains multiple variables**

- Leaf-list 'leaf-list-a' contains 2 variables inside one leaf-list
    entry: 'var-a' and 'var-b'.
- Both variables must be substituted by the same number of values.

```
{
  "leaf-list-a": [
    "ratio: {$var-a}%{$var-b}",
    "strX"
  ]
}
```

- Application of following values to variables 'var-a' and 'var-b':
    'var-a' = ['10', '20', '30'], 'var-b' = ['50', '70', '60'].

```
{
  "leaf-list-a": [
    "ratio: 10%50",
    "ratio: 20%70",
    "ratio: 30%60",
    "strX"
  ]
}
```

**F. Leaves and leaf-lists with escaped special characters**

- The following example demonstrates escaping of special characters
    outside of the variable identifier (leaf-list 'leaf-list-a') and
    inside of the variable identifier (leaf 'leaf-a').
- Unescaped identifier of the leaf 'leaf-a': 'var-{2}'.

```
{
  "leaf-list-a": [
    "{$var-1} text \\{\\$this-is-not-variable\\}"
  ],
  "leaf-a": "{$var-\\{2\\}}"
}
```

Substitution of 'var-1' by 'prefix' and 'var-{2}' by '10':

```
{
  "leaf-list-a": [
    "prefix text {$this-is-not-variable}"
  ],
  "leaf-a": 10
}
```

## Tags

By default, all templates have assigned 'merge' tag to the root
'configuration' container - if template doesn't explicitly define next
tags in the data-tree, then the whole template is merged to target
UniConfig node configuration at execution of apply-template RPC.
However, it is possible to set custom tags to data-tree elements of the
template.

Properties:

- Tags are represented in UniConfig using node attributes with the
    following identifier: 'template-tags:operation'.
- In RESTCONF, attributes are encoded using special notation that is
    explained in the 'RESTCONF' user guide.
- Tags are inherited through the data-tree of the template. If
    data-tree element doesn't define any tag, then it is inherited from
    parent element.
- Only single tag can be applied to one data node.
- Tags can be applied to following YANG structures: container, list,
    leaf-list, leaf, list entry, leaf-list entry.

Currently, the following tags are supported:

- **merge**: Merges with a node if it exists, otherwise creates the
    node.
- **replace**: Replaces a node if it exists, otherwise creates the
    node.
- **delete**: Deletes the node.
- **create**: Creates a node. The node can not already exist. An error
    is raised if the node exists.
- **update**: Merges with a node if it exists. If it does not exist,
    it will not be created.

### Examples with tags

**A. Tags applied to container, list, and leaf**

Template with name 'user\_template' that contains 'merge', 'replace',
and 'create' tags:

```
{
  "node": [
    {
      "node-id": "user_template",
      "frinx-uniconfig-topology:configuration": {
        "system:system": {
          "@": {
            "template-tags:operation": "update"
          },
          "users": {
            "@": {
              "template-tags:operation": "replace"
            },
            "#": [
              {
                "name": "test-${username}",
                "login": "{$login}",
                "role": "{$role}",
                "password": {
                  "@": {
                    "template-tags:operation": "create"
                  },
                  "#": "{$password}"
                }
              }
            ]
          }
        }
      }
    }
  ]
}
```

Description of all operations in the correct order that are done based
on the defined tags:

- Container 'configuration' will be merged to target UniConfig node
    (implicit root operation).
- Container 'system:system' will be updated - its content is merged
    only, if it has already been created.
- The whole list 'users' will replaced in the target UniConfig node.
- Leaf named 'password' will be created at the target UniConfig node -
    it cannot exist under 'users' list entry, otherwise the error will
    be raised.

**B: Tags applied to leaf-list, leaf-list entry, and list entry**:

The following JSON represents content of sample template with multiple
tags:

- 'replace' tag is applied to single list 'my-list' entry
- 'merge' tag is applied to whole 'leaf-list-a' leaf-list
- 'create' tag is applied to whole 'leaf-list-b' leaf-list
- 'delete' tag is applied to single leaf-list 'leaf-list-b' entry with
    value '10'

```
{
  "c1": {
    "my-list": [
      {
        "key": "k1",
        "value": 10,
        "@": {
          "template-tags:operation": "replace"
        }
      }
    ],
    "leaf-list-a": {
      "@": {
        "template-tags:operation": "merge"
      },
      "#": [
        10,
        20
      ]
    },
    "leaf-list-b": {
      "@": {
        "template-tags:operation": "create"
      },
      "#": [
        {
          "@": {
            "template-tags:operation": "delete"
          },
          "#": 10
        }
      ]
    }
  }
}
```

## Creation of template

A new template can be created by sending PUT request to new template
node under 'templates' topology with populated 'configuration'
container. Name of the template equals to name of the 'node' list entry.
This RESTCONF call must contain specified schema cache repository using
the 'uniconfig-schema-repository' query parameter in order to
successfully match sent data-tree with correct schema context (it is
usually associated with some type of NETCONF device).

### Example - creation of template

The following example shows creation of new template with name
'interface\_template' using 'schemas\_1' schema repository. The body of
the PUT request contains whole 'configuration' container.

```bash RPC Request
curl --location --request PUT 'http://localhost:8181/rests/data/network-topology:network-topology/topology=templates/node=interface_template/frinx-uniconfig-topology:configuration?uniconfig-schema-repository=schemas_1' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--data-raw '{
    "frinx-uniconfig-topology:configuration": {
        "interfaces:interfaces": [
            {
                "name": "eth-0/{$interface-id}",
                "enabled": "{$enabled}",
                "description": "purpose: '\''{$description}'\'''\''",
                "type": "{$type}",
                "unit": [
                    {
                        "@": {
                            "template-tags:operation": "replace"
                        },
                        "vlan-id": "{$unit-id}",
                        "enable": false,
                        "name": "{$unit-id}",
                        "family-inet": {
                            "address": [
                                {
                                    "@": {
                                        "template-tags:operation": "update"
                                    },
                                    "address": "{$ip-address}"
                                }
                            ]
                        }
                    }
                ]
            }
        ]
    }
}'
```

```json RPC Response, Status: 200
{
}
```

## Read/update/delete template

All CRUD operations with templates can be done using standard RESTCONF
PUT/DELETE/POST/PLAIN PATCH methods. As long as template contains some
data under 'configuration' container, next RESTCONF calls, that work
with templates, don't have to contain 'uniconfig-schema-repository'
query parameter, since type of the device is already known.

### Examples - RESTCONF operations

Reading specific subtree under 'interface\_template' - unit with name
'{\$unit-id}' that is placed under interface with name
'eth-0/{\$interface-id}'.

```bash RPC Request
curl --location --request GET 'http://localhost:8181/rests/data/network-topology:network-topology/topology=templates/node=interface_template/frinx-uniconfig-topology:configuration/interfaces:interfaces=eth-0%2F%7B%24interface-id%7D/unit=%7B%24unit-id%7D?content=config' \
--header 'Accept: application/json'
```

```json RPC Response, Status: 200
{
    "unit": [
        {
            "@": {
                "template-tags:operation": "replace"
            },
            "vlan-id": "{$unit-id}",
            "enable": false,
            "name": "{$unit-id}",
            "family-inet": {
                "address": [
                    {
                        "@": {
                            "template-tags:operation": "update"
                        },
                        "address": "{$ip-address}"
                    }
                ]
            }
        }
    ]
}
```

Changing 'update' tag of the 'address' list entry to 'create' tag using
PLAIN-PATCH RESTCONF method.

```bash RPC Request
curl --location --request PUT 'http://localhost:8181/rests/data/network-topology:network-topology/topology=templates/node=interface_template/frinx-uniconfig-topology:configuration/interfaces:interfaces=eth-0%2F%7B%24interface-id%7D/unit=%7B%24unit-id%7D/family-inet/address=%7B%24ip-address%7D' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--data-raw '{
    "address": [
        {
            "@": {
                "template-tags:operation": "create"
            },
            "address": "{$ip-address}"
        }
    ]
}'
```

```json RPC Response, Status: 200
{
}
```

## RPC get-template-info

This RPC shows information about all variables in specified template. The RPC input has to contain template name.

### Creation of template

```bash RPC Request
curl --location --request PUT 'http://localhost:8181/rests/data/network-topology:network-topology/topology=templates/node=interface_template/frinx-uniconfig-topology:configuration/Cisco-IOS-XR-ifmgr-cfg:interface-configurations/interface-configuration=%7B%24act-var%7D,%7B%24ifc-name-var%7D?uniconfig-schema-repository=schemas_1' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--data-raw '{
    "interface-configuration": [
        {
            "active": "{$act-var}",
            "interface-name": "{$ifc-name-var}",
            "shutdown": [
                "{$shutdown-var}"
            ]
        }
    ]
}'
```

```json RPC Response, Status: 201

```

### Usage of RPC

```bash RPC Request
curl --location --request POST 'http://localhost:8181/rests/operations/template-manager:get-template-info' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--data-raw '{
    "input": {
        "template-node-id": "interface_template"
    }
}'
```

```bash RPC Response
{
    "output": {
        "variables": {
            "variable": [
                {
                    "variable-name": "{$act-var}",
                    "type": "Cisco-IOS-XR-ifmgr-cfg:Interface-active",
                    "paths": {
                        "path": [
                            {
                                "path": "/network-topology:network-topology/topology=templates/node=interface_template/frinx-uniconfig-topology:configuration/Cisco-IOS-XR-ifmgr-cfg:interface-configurations/interface-configuration={%24act-var},{%24ifc-name-var}/active",
                                "path-description": "Whether the interface is active or\npreconfigured"
                            }
                        ]
                    },
                    "base-types": {
                        "base-type": [
                            {
                                "constraints": [
                                    "Length: [[0..2147483647]]",
                                    "Pattern: (act)|(pre)"
                                ],
                                "type": "string"
                            }
                        ]
                    },
                    "type-description": "act:The interface is active, pre:Preconfiguration"
                },
                {
                    "variable-name": "{$ifc-name-var}",
                    "type": "Cisco-IOS-XR-types:Interface-name",
                    "paths": {
                        "path": [
                            {
                                "path": "/network-topology:network-topology/topology=templates/node=interface_template/frinx-uniconfig-topology:configuration/Cisco-IOS-XR-ifmgr-cfg:interface-configurations/interface-configuration={%24act-var},{%24ifc-name-var}/interface-name",
                                "path-description": "The name of the interface"
                            }
                        ]
                    },
                    "base-types": {
                        "base-type": [
                            {
                                "constraints": [
                                    "Length: [[0..2147483647]]",
                                    "Pattern: (([a-zA-Z0-9_]*\\d+/){3}\\d+)|(([a-zA-Z0-9_]*\\d+/){4}\\d+)|(([a-zA-Z0-9_]*\\d+/){3}\\d+\\.\\d+)|(([a-zA-Z0-9_]*\\d+/){2}([a-zA-Z0-9_]*\\d+))|(([a-zA-Z0-9_]*\\d+/){2}([a-zA-Z0-9_]+))|([a-zA-Z0-9_-]*\\d+)|([a-zA-Z0-9_-]*\\d+\\.\\d+)|(mpls)|(dwdm)"
                                ],
                                "type": "string"
                            }
                        ]
                    },
                    "type-description": "An interface name specifying an interface type and\ninstance.\nInterface represents a string defining an interface\ntype and instance, e.g. MgmtEth0/4/CPU1/0 or\nTenGigE0/2/0/0.2 or Bundle-Ether9 or\nBundle-Ether9.98"
                },
                {
                    "variable-name": "{$shutdown-var}",
                    "type": "empty",
                    "paths": {
                        "path": [
                            {
                                "path": "/network-topology:network-topology/topology=templates/node=interface_template/frinx-uniconfig-topology:configuration/Cisco-IOS-XR-ifmgr-cfg:interface-configurations/interface-configuration={%24act-var},{%24ifc-name-var}/shutdown",
                                "path-description": "Shut the interface"
                            }
                        ]
                    },
                    "base-types": {
                        "base-type": [
                            {
                                "type": "empty"
                            }
                        ]
                    }
                }
            ]
        }
    }
}
```

## RPC get-template-nodes

This RPC returns all created templates from the template topology. No input body 
is required.

### Successful example

There is no template created in the template topology.

```bash RPC Request
curl --location --request POST 'http://localhost:8181/rests/operations/template-manager:get-template-nodes' \
--header 'Authorization: Basic YWRtaW46YWRtaW4=' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json'
```

```bash RPC Response
{
    "output": {}
}
```

### Successful example

There is a template 'test-template' created in template topology.

```bash RPC Request
curl --location --request POST 'http://localhost:8181/rests/operations/template-manager:get-template-nodes' \
--header 'Authorization: Basic YWRtaW46YWRtaW4=' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json'
```

```bash RPC Response
{
    "output": {
        "nodes": [
            "test-template"
        ]
    }
}
```

## Upgrading template to latest yang repository

Template can be upgraded to latest YANG repository using 'upgrade-template' RPC.
This procedure consists of:

1. **Read template** - Reading of template configuration from
    'templates' topology in Configuration datastore.
2. **Version-drop** - Conversion of template into target schema context
    that is created by specified yang-repository. Because of this feature, it is
    possible to change template between different versions of devices
    with different revisions of YANG schemas but with similar structure.
    Version-drop is also aware of 'ignoredDataOnWriteByExtensions'
    RESTCONF filtering mechanism.
3. **Removal of previous template / writing new template** - If
    'upgraded-template-name' is not specified in RPC input,
    previous template will be deleted and replaced by new one.
    If it is specified, previous template will not be deleted.

Description of input RPC fields:

- **template-name**: Name of the existing input template. This field is mandatory.
- **upgraded-template-name**: Name of upgraded/new template. This field is optional.
- **yang-repository**: Name of YANG repository against
    which version-dropping is used. This field is optional.
    If no yang-repository is specified, latest yang repository will be used.

Description of fields in RPC response:

No fields are used, only HTTP response codes [200 - OK, 404 - Fail]

### Usage of RPC

```bash RPC Request
curl --location --request POST 'http://localhost:8181/rests/operations/template-manager:upgrade-template' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--data-raw '{
    "input": {
        "template-name": "interface_template",
        "upgraded-template-name": "new_interface_template",
        "yang-repository": "schema1"
    }
}'
```

### Auto-upgrading of templates

This feature is used to automatically upgrade all stored templates using the old YANG repository
to the latest YANG repository with help from the version-drop procedure. For the auto-upgrading process to work,
the latest YANG repository must already be configured.
The upgrade process must be explicitly enabled in the configuration file and occurs when UniConfig is started.

There is also an option to back up templates before the upgrade with the standard rotation procedure.
The names of backed-up templates follow the pattern '{template-name}_backup_{index}', where '{template-name}' represents the name
of the original template and '{index}' represents the backup index. The most recent backup index is always '0' and older
ones are rotated by incrementing the corresponding index. If a backed-up template reaches the configured
limit (maximum number of backups), it is permanently removed from the database.

Overview of available settings ('config/lighty-uniconfig-config.json'):

```json default auto-upgrading settings
{
    "templates": {
        "enabledTemplatesUpgrading": false,
        "backupTemplatesLimit": 7
    }
}
```

- **enabledTemplatesUpgrading** - Enables the auto-upgrading process at UniConfig startup. If disabled, the other setting is ignored.
- **backupTemplatesLimit** - Maximum number of stored backup templates. If exceeded, older templates are removed during the
  rotation procedure. If set to 0, templates are not backed up at all.

## Application of template

Template can be applied to UniConfig nodes using 'apply-template' RPC.
This procedure does following steps:

1. **Read template** - Reading of template configuration from
    'templates' topology in Configuration datastore.
2. **String-substitution** - Substitution of variables by provided
    values or default values, if there aren't any provided values for
    some variables and leaf/leaf-list defines a default values. If some
    variables cannot be substituted (for example, user forgot to specify
    input value of variable), an error will be returned.
3. **Version-drop** - Conversion of template into target schema context
    that is used by target UniConfig node. This component also drops
    unsupported data from input template. Because of this feature, it is
    possible to apply template between different versions of devices
    with different revisions of YANG schemas but with similar structure.
    Version-drop is also aware of 'ignoredDataOnWriteByExtensions'
    RESTCONF filtering mechanism.
4. **Application of tags** - Data-tree of the template is streamed and
    data is applied to target UniConfig node based on set tags on data
    elements, recursively. UniConfig node configuration is updated only
    in the Configuration datastore.

Description of input RPC fields:

- **template-node-id**: Name of the existing input template.
- **uniconfig-node**: List of target UniConfig nodes to which template
    is applied ('uniconfig-node-id' is the key).
- **uniconfig-node-id**: Target UniConfig node identifier.
- **variable**: List of variables and substituted values that must be
    used during application of template to UniConfig node. Variables
    must be set per target UniConfig node since it is common, that
    values of variables should be different on different devices. Leaf
    'variable-id' represents the key of this list.
- **variable-id**: Unescaped variable identifier.
- **leaf-value**: Scalar value of the variable. Special characters
    ('\$', '{', '}') must be escaped.
- **leaf-list-values**: List of values - it can be used only with
    leaf-lists. Special characters ('\$', '{', '}') must be escaped.

Description of fields in RPC response:

- **overall-status**: Overall status of the operation as the whole. If
    application of the template fails on at least one UniConfig node,
    then overall-status will be set to 'fail' (no modification will be
    done in datastore). Otherwise, it will be set to 'complete'.
- **node-result**: Per target UniConfig node results. The rule is
    following - all input UniConfig node IDs must also present in the
    response.
- **node-id**: Target UniConfig node identifier (key of the list).
- **status**: Status of the operation: 'complete' or 'fail'.
- **error-message** (optional): Description of the error that occurred
    during application of template.
- **error-type** (optional): Type of the error.

The following sequence diagram and nested activity diagram show process
of 'apply-template' RPC in detail.

![RPC apply-template](apply_template.svg)

![Processing template configuration](processing_template.svg)

### Examples - apply-template calls

Successful application of the template 'service\_group' to 2 UniConfig
nodes - 'dev1' and 'dev2'.

```bash RPC Request
curl --location --request PUT 'http://localhost:8181/rests/operations/template-manager:apply-template' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--data-raw '{
    "input": {
        "template-node-id": "service_group",
        "uniconfig-node": [
            {
                "uniconfig-node-id": "dev1",
                "variable": [
                    {
                        "variable-id": "svc-id",
                        "leaf-value": 1
                    },
                    {
                        "variable-id": "svc-1",
                        "leaf-value": "my-sng"
                    },
                    {
                        "variable-id": "svc-type",
                        "leaf-value": "other"
                    },
                    {
                        "variable-id": "svc-service",
                        "leaf-list-values": [
                            "sdwan",
                            "cgnat"
                        ]
                    }
                ]
            },
            {
                "uniconfig-node-id": "dev2",
                "variable": [
                    {
                        "variable-id": "svc-id",
                        "leaf-value": 1
                    },
                    {
                        "variable-id": "svc-1",
                        "leaf-value": "custom-sng"
                    },
                    {
                        "variable-id": "svc-type",
                        "leaf-value": "internal"
                    },
                    {
                        "variable-id": "svc-service",
                        "leaf-list-values": [
                            "sdwan"
                        ]
                    }
                ]
            }
        ]
    }
}'
```

```json RPC Response, Status: 200
{
    "output": {
        "overall-status": "complete",
        "node-result": [
            {
                "node-id": "dev1",
                "status": "complete"
            },
            {
                "node-id": "dev2",
                "status": "complete"
            }
        ]
    }
}
```

Failed application of the template 'temp1' - template doesn't exist.

```bash RPC Request
curl --location --request PUT 'http://localhost:8181/rests/operations/template-manager:apply-template' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--data-raw '{
    "input": {
        "template-node-id": "temp1",
        "uniconfig-node": [
            {
                "uniconfig-node-id": "dev1",
                "variable": [
                    {
                        "variable-id": "remote-ip",
                        "leaf-value": "172.30.15.1"
                    },
                    {
                        "variable-id": "mode",
                        "leaf-value": "vpn"
                    }
                ]
            }
        ]
    }
}'
```

```json RPC Response, Status: 200
{
    "output": {
        "overall-status": "fail",
        "node-result": [
            {
                "node-id": "dev1",
                "error-type": "uniconfig-error",
                "status": "fail"
            }
        ],
        "error-message": "Template with node ID 'temp1' is not present in CONFIG datastore."
    }
}
```

Failed application of the template 'service\_group' to 2 UniConfig nodes
- 'dev1' and 'dev2' - user hasn't provided values for all required
variables.

```bash RPC Request
curl --location --request PUT 'http://localhost:8181/rests/operations/template-manager:apply-template' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--data-raw '{
    "input": {
        "template-node-id": "redundancy_template",
        "uniconfig-node": [
            {
                "uniconfig-node-id": "dev1",
                "variable": [
                    {
                        "variable-id": "local-ip",
                        "leaf-value": "172.30.15.1"
                    },
                    {
                        "variable-id": "redundant-mode",
                        "leaf-value": "service"
                    }
                ]
            },
            {
                "uniconfig-node-id": "dev2",
                "variable": [
                    {
                        "variable-id": "local-ip",
                        "leaf-value": "172.30.15.1"
                    },
                    {
                        "variable-id": "redundant-mode",
                        "leaf-value": "service"
                    },
                    {
                        "variable-id": "min-interval",
                        "leaf-value": 100
                    }
                ]
            }
        ]
    }
}'
```

```json RPC Response, Status: 200
{
    "output": {
        "overall-status": "fail",
        "node-result": [
            {
                "node-id": "dev1",
                "error-type": "uniconfig-error",
                "status": "fail",
                "error-message": "String substitution failed: Node /network-topology:network-topology/topology=templates/node=redundancy_template/frinx-uniconfig-topology:configuration/ha:redundancy/intra-chassis/bfd-liveness-detection/transmit-interval/minimum-interval has defined variable/s: '[min-interval]', but there is not provided or default value for all of these variables"
            },
            {
                "node-id": "dev2",
                "error-type": "uniconfig-error",
                "status": "fail"
            }
        ]
    }
}
```

Failed application of the template 'redundancy\_template' to UniConfig
node 'dev1' - type of the substituted variable value is invalid (failed
regex constraint).

```bash RPC Request
curl --location --request PUT 'http://localhost:8181/rests/operations/template-manager:apply-template' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--data-raw '{
    "input": {
        "template-node-id": "redundancy_template",
        "uniconfig-node": [
            {
                "uniconfig-node-id": "dev1",
                "variable": [
                    {
                        "variable-id": "local-ip",
                        "leaf-value": "172.30.15.1s"
                    },
                    {
                        "variable-id": "redundant-mode",
                        "leaf-value": "service"
                    },
                    {
                        "variable-id": "control-mode",
                        "leaf-value": "vcn1"
                    },
                    {
                        "variable-id": "min-interval",
                        "leaf-value": "50"
                    }
                ]
            }
        ]
    }
}'
```

```json RPC Response, Status: 200
{
    "output": {
        "overall-status": "fail",
        "node-result": [
            {
                "node-id": "dev1",
                "error-type": "uniconfig-error",
                "status": "fail",
                "error-message": "Value '172.30.15.1s' cannot be applied to leaf /network-topology:network-topology/topology=templates/node=redundancy_template/frinx-uniconfig-topology:configuration/ha:redundancy/inter-chassis/local-ip - it accepts only values with following YANG types: [type: string, constraints: [Length[[0..2147483647]], PatternConstraintImpl{regex=^(?:(([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(%[\\p{N}\\p{L}]+)?)$, errorAppTag=invalid-regular-expression}], type: string, constraints: [Length[[0..2147483647]], PatternConstraintImpl{regex=^(?:((:|[0-9a-fA-F]{0,4}):)([0-9a-fA-F]{0,4}:){0,5}((([0-9a-fA-F]{0,4}:)?(:|[0-9a-fA-F]{0,4}))|(((25[0-5]|2[0-4][0-9]|[01]?[0-9]?[0-9])\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9]?[0-9])))(%[\\p{N}\\p{L}]+)?)$, errorAppTag=invalid-regular-expression}, PatternConstraintImpl{regex=^(?:(([^:]+:){6}(([^:]+:[^:]+)|(.*\\..*)))|((([^:]+:)*[^:]+)?::(([^:]+:)*[^:]+)?)(%.+)?)$, errorAppTag=invalid-regular-expression}]]"
            }
        ]
    }
}
```

## RPC create-multiple-templates

One or more new templates can be created by this RPC. Templates are parsed and written in parallel
for better performance. If specified templates already exist, their configuration is replaced.
Execution of RPC is atomic - either all templates are successfully created or no changes are made
in the UniConfig transaction.

Description of input RPC fields:

- **template-name**:Name of the created template.
- **yang-repository**: YANG schema repository used for parsing of template configuration. Default value: 'latest'.
- **template-configuration**: Whole template configuration.
- **tags**: List of template tags that are written on the specified paths in all created templates.
  Specified tag type must be prefixed with 'template-tags' module name based on RFC-8040 formatting of identityref.

Only template-name and template-configuration are mandatory fields.

### Examples

Successful creation of templates.

```bash RPC Request
curl --location --request POST 'http://localhost:8181/rests/operations/template-manager:create-multiple-templates' \
--header 'Content-Type: application/json' \
--data-raw '{
    "input": {
        "templates": [
            {
                "template-name": "Template-name1",
                "yang-repository": "schema-1779846763",
                "template-configuration": {
                    "system:system-config": {
                        "@": {
                            "template-tags:operation": "replace"
                        },
                        "timezone": "CEST"
                    }
                }
            },
            {
                "template-name": "Template-name2",
                "yang-repository": "schema-1779846763",
                "template-configuration": {
                    "interfaces:interfaces": [
                        {
                            "name": "e0",
                            "description": "test"
                        }
                    ]
                }
            },
            {
                "template-name": "Template-name3",
                "template-configuration": {
                    "dhcp:dhcp": {
                        "enabled": true
                    },
                    "services": ["dhcp"]
                }
            }
        ]
    }
}'
```

```json RPC Response, Status: 200
{
    "output": {
        "overall-status": "complete",
        "node-result": [
            {
                "node-id": "Template-name1",
                "status": "complete"
            },
            {
                "node-id": "Template-name2",
                "status": "complete"
            },
            {
                "node-id": "Template-name3",
                "status": "complete"
            }
        ]
    }
}
```

Failed to find YANG schema repository.

```bash RPC Request
curl --location --request POST 'http://127.0.0.1:8181/rests/operations/template-manager:create-multiple-templates' \
--header 'Content-Type: application/json' \
--data-raw '{
    "input": {
        "templates": [
            {
                "template-name": "Template-name1",
                "yang-repository": "schema-1",
                "template-configuration": {
                    "system:system-config": {
                        "@": {
                            "template-tags:operation": "replace"
                        },
                        "timezone": "CEST"
                    }
                }
            },
            {
                "template-name": "Template-name2",
                "yang-repository": "schema-2",
                "template-configuration": {
                    "system:system-config": {
                        "@": {
                            "template-tags:operation": "replace"
                        },
                        "timezone": "CEST"
                    }
                }
            }
        ]
    }
}'
```

```json RPC Response, Status: 200
{
    "output": {
        "overall-status": "fail",
        "node-result": [
            {
                "node-id": "Template-name1",
                "error-type": "uniconfig-error",
                "error-message": "Failed to find schema repository: schema-1",
                "status": "fail"
            },
            {
                "node-id": "Template-name2",
                "error-type": "uniconfig-error",
                "status": "fail"
            }
        ]
    }
}
```

Failed to parse template configuration.

```bash RPC Request
curl --location --request POST 'http://127.0.0.1:8181/rests/operations/template-manager:create-multiple-templates' \
--header 'Content-Type: application/json' \
--data-raw '{
    "input": {
        "templates": [
            {
                "template-name": "Template-name1",
                "yang-repository": "schema-1",
                "template-configuration": {
                    "system:system-config": {
                        "@": {
                            "template-tags:operation": "replace"
                        },
                        "timezone": "CEST"
                    }
                }
            },
            {
                "template-name": "Template-name2",
                "yang-repository": "schema-2",
                "template-configuration": {
                    "dhcp:dhcp": {
                        "enabled": true
                    },
                    "service": ["dhcp"]
                }
            }
        ]
    }
}'
```

```json RPC Response, Status: 200
{
    "output": {
        "overall-status": "fail",
        "node-result": [
            {
                "node-id": "Template-name1",
                "status": "fail",
                "error-type": "uniconfig-error"
            },
            {
                "node-id": "Template-name2",
                "error-type": "uniconfig-error",
                "status": "fail",
                "error-message": "Node with name 'service' has not been found under 'configuration'"
            }
        ]
    }
}
```

Creation of 2 templates with separately specified template tags - 'replace' tag is added to '/acl/category' and
'/services/group=default/types' elements, while 'create' is added to '/services' element.

```bash RPC request
curl --location --request POST 'http://127.0.0.1:8181/rests/operations/template-manager:create-multiple-templates' \
--header 'Content-Type: application/json' \
--data-raw '{
  "input": {
    "templates": [
      {
        "template-name": "Template-name1",
        "yang-repository": "schema1",
        "template-configuration": {
          "acl": {
            "rules": [
              {
                "name": "test-name",
                "category": [
                  "*"
                ]
              }
            ]
          }
        }
      },
      {
        "template-name": "Template-name2",
        "template-configuration": {
          "services": {
            "group": [
              {
                "name": "default",
                "id": 0,
                "type": "internal",
                "types": [
                  "test"
                ]
              }
            ]
          }
        }
      }
    ],
    "tags": [
      {
        "tag": "template-tags:replace",
        "paths": [
          "/acl/category",
          "/services/group=default/types"
        ]
      },
      {
        "tag": "template-tags:create",
        "paths": [
          "/services"
        ]
      }
    ]
  }
}
```

```json RPC response
{
  "output": {
    "overall-status": "complete",
    "node-result": [
      {
        "node-id": "Template-name1",
        "status": "complete"
      },
      {
        "node-id": "Template-name2",
        "status": "complete"
      }
    ]
  }
}
```