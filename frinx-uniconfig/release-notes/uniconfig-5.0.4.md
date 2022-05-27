---
order: 12
---

# UniConfig 5.0.4

## :white_check_mark: New Features

### Adding option to use json-path also for selection of some subtrees
Currently, jsonpath language can be used in UniConfig only for filtering of data. 
However, the language itself allows also to select some data using provided json-path.

We need to expose this functionality in UniConfig API using some query parameter (the similar way as it is done for filtering) and also expose this functionality in the uniconfig-client.

### Shell: scrolling output (--more--)

Long UniConfig shell output should be displayed using some scrolling mechanism (equivalent to ‘more' or 'less’ linux tools).

### Add 'show history' command to uniconfig-shell
It should display last N commands that were executed in the shell. Syntax:

```
show history [max-number-of-output-commands]
```

Parameter 'max-number-of-output-commands' should be optional.

This command should be available from both operational and configuration modes.

### Add support for aliases inside uniconfig shell

There should be some configuration file in the config directory that will contain defined aliases. 
It should support also place-holders/variables for both values and arrays.

``` Example:
{
  "configuration-mode": {
    "diff": "request calculate-diff target-nodes/node *"
  },
  "request": {
    "shcs": "show-connection-status target-nodes/node *"
  },
  "show": {
    "lbr": "logging-status broker restconf"
  }
}
```

+ Supporting autocomplete on aliases.

## :bulb: Improvements

### Improve maven plugin for generation Java classes

- yang packager: generate sources only for latest repository
- settings: package name - option to change it
- setting: disable prefix + javadoc on data-elements

## :x: Bug Fixes

### NETCONF sessions used for receiving NETCONF notifications stop working

UniConfig does not use keepalive messages for checking, if NETCONF session used for receiving of NETCONF notifications is still alive and triggering reconnection procedure.
As a consequence, if connection is dropped without explicit TCP interruption, then UC will not find it out and doesn’t try to re-create connection. 
However, device is using some form of TCP keepalive messages - device will drop connection after some time.

**FIX:** Uniconfig is enables and tracks keepalive messages also for NETCONF sessions that are used for NETCONF streams

### Optimisation of jsonb-filtering

It seems that jsonb-filtering causes reading of whole configuration from PG into UC even if it should not be necessary:

- checking existence of the node - currently it works by using DOM ‘exists’ operation that reads whole configuration from DB
- deriving uniconfig-native prefix / YANG repository - it is derived from configuration, not from DB metadata

**FIX:** stopping verification of node, if jsonb-filer is used. It required reading of whole config from DB to Uniconfig what making the call much slower.

### Uc shell: after config/request commit the prompt was changed unexpectedly from request> to config>

**Previous behaviour:**

```
uniconfig>configuration-mode 
config>request 
request>replace-config-with-snapshot 
{
  "error-message": "Nodes are not specified in input request.",
  "overall-status": "fail"
}
request>replace-config-with-snapshot name stano target-nodes/node xr5
{
  "node-results": {
    "node-result": [
      {
        "node-id": "xr6",
        "status": "complete"
      },
      {
        "node-id": "xr5",
        "status": "complete"
      },
      {
        "node-id": "versa",
        "status": "complete"
      }
    ]
  },
  "overall-status": "complete"
}
request>commit
{
  "node-results": {
    "node-result": [
      {
        "node-id": "xr5",
        "configuration-status": "complete"
      }
    ]
  },
  "overall-status": "complete"
}
config>replace-config-with-snapshot name stano target-nodes/node versa
config>
```

**After fix:** 

```
request>commit
{
  "node-results": {
    "node-result": [
      {
        "node-id": "xr5",
        "configuration-status": "complete"
      }
    ]
  },
  "overall-status": "complete"
}
request>
```

### Uc shell: config mode / show or delete - CREATE OBJECT option should be removed

**Previous behaviour:**

```
stanislav@stanislav-latitude-5501:~/work/system-tests$ ssh -p 2022 admin@127.0.0.1
Password authentication
Password: 
uniconfig>configuration-mode 
config>show 
show>template 
show-tp>
others
exit (return to parent mode)   quit   (return to root mode)
templates
versa.templatesng
others
       (create new template)
```

e.g. here (create new template) should not be present here. Similarly others places in program. Behaviour like this is not expected by user.

**After fix:**

```
uniconfig>configuration-mode 
config>show
show>template 
show-tp>
exit                         (return to parent mode)   quit                           (return to root mode)   show-history (show history [max number of commands])
```

### Uniconfig 5.0.3 prints out error on start

```
07:14:15.185 INFO io.frinx.uniconfig.device.discovery.impl.DeviceDiscoveryServiceImpl - Device discovery started.
Exception in thread "main" java.lang.NullPointerException
        at io.frinx.uniconfig.southbound.connection.notifications.filters.NetconfStreamFilter.<init>(NetconfStreamFilter.java:30)
        at io.frinx.uniconfig.southbound.connection.notifications.AbstractTopologyConnectionChangeHandler.initializeFilters(AbstractTopologyConnectionChangeHandler.java:83)
        at io.frinx.uniconfig.southbound.connection.notifications.AbstractTopologyConnectionChangeHandler.<init>(AbstractTopologyConnectionChangeHandler.java:66)
        at io.frinx.uniconfig.southbound.connection.notifications.GnmiConnectionChangeHandler.<init>(GnmiConnectionChangeHandler.java:37)
        at io.frinx.uniconfig.southbound.connection.notifications.ConnectionChangeListener.<init>(ConnectionChangeListener.java:25)
        at io.frinx.uniconfig.southbound.connection.notifications.ConnectionNotificationService.<init>(ConnectionNotificationService.java:33)
        at io.frinx.lighty_uniconfig.Main.main(Main.java:160)
```

**Fix:** error message in the log was displayed when notifications were set to false in the lighty-uniconfig-config.json file. 
This error message is no longer displayed. 

### Flyway migration failed

Migration of data in the database when switching to another version throws error causing that uniconfig is unable to start.

### Yang patch operation does not work correctly with leaf list

There are several issues with yang patch when operating on leaf-lists. In particular I have found issues with the insert operation and the merge operation.

**Merge operation case:**

If the leaf list does not exist, then the merge operation pass without problems. 
However, if the leaf list does already exist, then the merge fails with following error message:

```
{
  "errors": {
    "error": [
      {
        "error-message": "39dcf48c-2cd5-47a1-aa65-18e359201f80: The commit RPC returned FAIL status. \n Unsupported type of node ImmutableLeafSetNode{nodeIdentifier=(http://openconfig.net/yang/vlan?revision=2018-11-21)trunk-vlans, value=UnmodifiableCollection{[ImmutableLeafSetEntryNode{nodeIdentifier=(http://openconfig.net/yang/vlan?revision=2018-11-21)trunk-vlans[20], value=20, attributes={}}, ImmutableLeafSetEntryNode{nodeIdentifier=(http://openconfig.net/yang/vlan?revision=2018-11-21)trunk-vlans[10], value=10, attributes={}}]}, attributes={}}",
        "error-tag": "bad-element",
        "error-type": "rpc"
      }
    ]
  }
}
```

**Insert operation case:**

```
{
  "ietf-yang-patch:yang-patch-status": {
    "patch-id": "some-id-identifying-this-patch",
    "edit-status": {
      "edit": [
        {
          "edit-id": "1",
          "errors": {
            "error": [
              {
                "error-type": "protocol",
                "error-tag": "data-exists",
                "error-path": "network-topology:network-topology/topology=uniconfig/node=sonic/frinx-uniconfig-topology:configuration/native-gnmi-topology-openconfig-interfaces:interfaces/interface=PortChannel1/native-gnmi-topology-openconfig-if-aggregate:aggregation/native-gnmi-topology-openconfig-vlan:switched-vlan/config",
                "error-message": "Data already exists"
              }
            ]
          }
        }
      ]
    }
  }
}
```

### PATCH operation does not work with some paths and target combination

**Overview**
RestConf PATCH operation does not work with certain combination of URL and target

**Details**

Request URL ({{url}} is the UniConfig host, {{node}} is the id under which the Sonic device is installed):

`http://{{url}}/rests/data/network-topology:network-topology/topology=uniconfig/node={{node}}/frinx-uniconfig-topology:configuration/openconfig-interfaces:interfaces/interface=Ethernet52`

**Method: PATCH**
**Request body:**

```
{
  "yang-patch": {
    "patch-id": "merge-value-list-entry",
    "comment": "Merge new values in list entry",
    "edit": [
      {
        "edit-id": "1",
        "operation": "merge",
        "target": "/",
        "value": {
          "openconfig-interfaces:interface": [
            {
              "openconfig-if-ethernet:ethernet": {
                "config": {
                  "openconfig-if-aggregate:aggregate-id": "1"
                }
              },
              "name": "Ethernet52"
            }
          ]
        }
      }
    ]
  }
}
```

**Produce this response:**

```
{
  "errors": {
    "error": [
      {
        "error-type": "protocol",
        "error-message": "Error parsing json input: Schema for node with name interface and namespace http://openconfig.net/yang/interfaces does not exist at AbsoluteSchemaPath{path=[]}",
        "error-tag": "malformed-message",
        "error-info": "Schema for node with name interface and namespace http://openconfig.net/yang/interfaces does not exist at AbsoluteSchemaPath{path=[]}"
      }
    ]
  }
}
```

**Request body:** 

```
{
  "yang-patch": {
    "patch-id": "merge-value-list-entry",
    "comment": "Merge new values in list entry",
    "edit": [
      {
        "edit-id": "1",
        "operation": "merge",
        "target": "/openconfig-if-ethernet:ethernet",
        "value": {
          "openconfig-if-ethernet:ethernet": {
            "config": {
              "openconfig-if-aggregate:aggregate-id": "1"
            }
          }
        }
      }
    ]
  }
}
```


Produce empty response body with error code 500. **UniConfig logs have this record:**

```
java.lang.IllegalArgumentException: Instance identifier references (native-gnmi-topology-http://openconfig.net/yang/interfaces/ethernet?revision=2020-05-06)ethernet but data identifier is AugmentationIdentifier{childNames=[(native-gnmi-topology-http://openconfig.net/yang/interfaces/ethernet?revision=2020-05-06)ethernet]}
```

### Portchannel trunk-vlans replace

When one trunk vlan is already set on porchannel, then put request to change trunk vlans list returns:

`Unsupported type of node …`

Current workaround is deleting whole list of trunk-vlans, after that single put request to add removed and new trunk-vlans.

Postman collection is attached. **Replace can be also done using this gnmic command:**

```
gnmic set -a 10.10.19.64:8013 -u admin -p pt123 --skip-verify --timeout 10m --target OC_YANG \
--replace-path '/openconfig-interfaces:interfaces/interface[name=PortChannel1]/openconfig-if-aggregate:aggregation/openconfig-vlan:switched-vlan/config/trunk-vlans' \
--replace-file use-cases/uc1Json/vlanPortchannelMember.json --encoding json_ietf
```
