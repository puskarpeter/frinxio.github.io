# VLAN

## URL
```
network-instances/network-instance=default/vlans/vlan={{vlan_id}}
```

## OPENCONFIG YANG
[YANG models](https://github.com/FRINXio/openconfig/tree/master/network-instance/src/main/yang)

```javascript
{
    "vlan": [
        {
            "vlan-id": {{vlan_id}},
            "config": {
                "vlan-id": {{vlan_id}},
                "name": {{vlan_name}},
                "status": "{{vlan_status}}",
                "frinx-dasan-vlan-extension:eline": {{eline_enabled}},
                "frinx-saos-vlan-extension:egress-tpid": "{{vlan_tpid}}"
            },
            "frinx-saos-virtual-ring-extension:rings": {
                "ring": [
                    {
                        "name": "{{ring-name}}",
                        "config": {
                            "name": "{{ring-name}}"
                        }
                    }
                ]
            },
            "frinx-saos-vlan-extension:relay-agent": {
                "config": {
                    "enable": {{enable}},    // true or false
                    "ports": [
                        {
                            "port-name": "{{port_name}}",
                            "config": {
                                "port-name": "{{port_name}}",
                                "trust-mode": "{{trust_mode_enum}}"
                            }
                        }
                    ]
                }
            }
        }
    ]
}
```

## OS Configuration Commands
### Cisco IOS Classic (15.2(4)S5) / XE (15.3(3)S2)
#### CLI
<pre>
vlan {{vlan_id}}
 name {{vlan_name}}
 shutdown | no shutdown
</pre>

*no shutdown* is a conversion of {{vlan_status}} set *ACTIVE*  
*shutdown* is a conversion of {{vlan_status}} set *SUSPENDED*

### Dasan NOS SFU.RR.5.6p5
#### CLI
if {{eline_enabled}} is true
<pre>
bridge
 vlan create {{vlan_id}} eline
!
</pre>

if {{eline_enabled}} is false
<pre>
bridge
 vlan create {{vlan_id}}
!
</pre>

## Ciena SAOS 614
#### CLI
<pre>vlan create vlan {{vlan_id}}
vlan set vlan {{vlan_id}} name {{vlan_name}}
vlan set vlan {{vlan_id}} egress-tpid {{vlan_tpid_e}}
ring-protection virtual-ring add ring {{ring-name}} vid {{vlan-id}}
dhcp l2-relay-agent create vlan {{vlan_id}}
dhcp l2-relay-agent enable | disable vlan {{vlan_id}}
dhcp l2-relay-agent set vlan {{vlan_id}} port {{port_name}} trust-mode {{trust_mode_enum}}</pre>

{{vlan_tpid}} should be pure numeric, converted from oc-vlan-types:TPID_TYPES from openconfig  
*enable* is a conversion of {{enable}} to *true*  
*disable* is a conversion of {{enable}} to *false*  
{{trust_mode_enum}} is an enumeration trust-mode - options are *client-trusted*, *server-trusted*, *dualrole-trusted* and *untrusted*  
