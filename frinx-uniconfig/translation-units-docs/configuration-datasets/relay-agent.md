# Relay Agent


## URL

```
frinx-openconfig-relay-agent:relay-agent
```

## OPENCONFIG YANG


[YANG models](https://github.com/FRINXio/openconfig/tree/master/relay-agent/src/main/yang)

```javascript
{
    "frinx-openconfig-relay-agent:relay-agent": {
        "dhcp": {
            "frinx-saos-relay-agent-extension:relay-agent": {
                "config": {
                    "remote-id-type": "{{remote_id_type}}",
                    "replace-option82": {{replace_option82}},
                    "enable": {{relay_agent_enable}}
                }
            }
        }
    }
}
```

## OS Configuration Commands

### SAOS 6

#### CLI

<pre> 
dhcp l2-relay-agent {{relay_agent_enable}}
dhcp l2-relay-agent set remote-id-type {{remote_id_type}}
dhcp l2-relay-agent set replace-option82 {{replace_option82}}
</pre>

*true or false* is conversion of {{relay_agent_enable}} set to "enable"  
*rid-string, device-hostname, device-mac* is conversion of {{remote_id_type}} set to "remote_id_type"  
*true or false* is conversion of {{replace_option82}} set to "replace-option82"  

<pre>
dhcp l2-relay-agent disable
dhcp l2-relay-agent unset remote-id-type
dhcp l2-relay-agent unset replace-option82
</pre>

##### Unit

Link to GitHub : [saos6-unit](https://github.com/FRINXio/cli-units/tree/master/saos/saos-6/saos-6-relay-agent)

### SAOS 8

#### CLI

<pre> 
dhcp l2-relay-agent {{relay_agent_enable}}
dhcp l2-relay-agent set remote-id-type {{remote_id_type}}
dhcp l2-relay-agent set replace-option82 {{replace_option82}}
</pre>

*true or false* is conversion of {{relay_agent_enable}} set to "enable"  
*rid-string, device-hostname, device-mac* is conversion of {{remote_id_type}} set to "remote_id_type"  
*true or false* is conversion of {{replace_option82}} set to "replace-option82"

<pre>
dhcp l2-relay-agent disable
dhcp l2-relay-agent unset remote-id-type
dhcp l2-relay-agent unset replace-option82
</pre>

##### Unit

Link to GitHub : [saos8-unit](https://github.com/FRINXio/cli-units/tree/master/saos/saos-6/saos-8-relay-agent)


