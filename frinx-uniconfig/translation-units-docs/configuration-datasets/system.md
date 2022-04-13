# System-wide services and functions

## URL

```
frinx-openconfig-system:system
```

## OPENCONFIG YANG

[YANG models](https://github.com/FRINXio/openconfig/tree/master/system/src/main/yang)

```javascript
{
    "frinx-openconfig-system:system": {
        "ntp": {
            "servers": {
                "server" [
                    {
                        "address": "{{source_ip_address}}",
                        "config": {
                            "address": "1{{source_ip_address}}",
                            "frinx-cisco-ntp-extension:vrf": "{{vpn}}"
                        }
                    }
                ]
            }
            "frinx-cisco-ntp-extension:source-interface": {
                "config": {
                    "name": "{{ifc_name}}"
                }
            }
            "frinx-cisco-ntp-extension:access-group": {
                "config": {
                    "serve-only": "{{acl_serve_only}}",
                    "query-only": "{{acl_query_only}}",
                    "serve": "{{acl_serve}}",
                    "peer": "{{acl_peer}}"
                }
            }
        }

    }
}
```

## OS Configuration Commands

### IOS XE ASR920

#### CLI

<pre>
ntp server vrf {{vpn}} {{source_ip_address}}
ntp source {{ifc_na}}
ntp access-group peer {{acl_peer}}
ntp access-group serve {{acl_serve}}
ntp access-group serve-only {{acl_serve_only}}
ntp access-group query-only {{acl_query_only}}
</pre>

##### Unit

Link to github : [ios-xe-unit]
