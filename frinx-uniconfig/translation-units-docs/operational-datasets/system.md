# System

## URL

```
frinx-openconfig-system:ntp
```

## OPENCONFIG YANG

[YANG models](https://github.com/FRINXio/openconfig/tree/master/platform/src/main/yang)

```javascript
{
    "system": {
        "ntp": {
            "ntp-keys": {
                "ntp-key" [
                    {
                        "key-id": <key_id>,
                        "state": {
                            "frinx-ciena-ntp-extension:key-type": "<key_type>",
                            "key-id": <key_id>
                        },
                        "config": {
                            "key-id": <key_id>
                        }
                    }
                ]
            },
            "servers": {
                "server": [
                    {
                        "address": "<server_address>",
                        "state": {
                            "address": "<server_address>",
                            "frinx-ciena-ntp-extension:admin-state": "<admin_state>",
                            "frinx-ciena-ntp-extension:ip-address": "<server_ip_address>",
                            "frinx-ciena-ntp-extension:host-name": "<server_host_name>",
                            "frinx-ciena-ntp-extension:server": {
                                "offset": "<server_offset>",
                                "auth-state": "<server_auth_state>",
                                "condition": "<server_condition>",
                                "server-state": "<server_state>"
                            },
                            "frinx-ciena-ntp-extension:oper-state": "<server_oper_state>",
                            "frinx-ciena-ntp-extension:config-state": "<server_config_state>",
                            "frinx-ciena-ntp-extension:auth-key-id": "<server_auth_key_id>",
                            "frinx-ciena-ntp-extension:index": <server_index>,
                            "frinx-ciena-ntp-extension:stratum": <server_stratum>
                        },
                        "config": {
                            "address": "<server_address>"
                        }
                    }
                ]
            }
        }
    }
}
```

## OS Configuration Commands

### Ciena SAOS 6

#### CLI

---
<pre>
SAOS6&gt; ntp client show keys

+-- NTP AUTHENTICATION KEYS --+
| Key ID       | Type         |
+--------------+--------------+
| &lt;key_id&gt;     | &lt;key_type&gt;   |
+--------------+--------------+

SAOS6&gt;ntp client show

+------------------- NTP CLIENT STATE --------------------+
| Parameter                 | Value                       |
+---------------------------+-----------------------------+
|                           |                             |
+---------------------------+-----------------------------+


+---------------------------------------------------- NTP SERVER CONFIGURATION ----------------------------------------------------+
|                                         |                      |  Auth   |  Config   |Admin|Oper |Server| Server  |Auth | Offset |
| IP Address                              | Host Name            | Key ID  |  State    |State|State|State |Condition|State| (ms)   |
+-----------------------------------------+----------------------+---------+-----------+-----+-----+------+---------+-----+--------+
|&lt;server_address&gt;                         |                      |         |           |     |     |      |         |     |        |
+-----------------------------------------+----------------------+---------+-----------+-----+-----+------+---------+-----+--------+

+-- NTP AUTHENTICATION KEYS --+
| Key ID       | Type         |
+--------------+--------------+
|              |              |
+--------------+--------------+


+-------------------------- NTP MULTICAST ADDRESSES ---------------------------+
|                                                                              |
+------------------------------------------------------------------------------+

SAOS6&gt;ntp client show server &lt;server_address&gt;

+-------------------------- NTP SERVER CONFIGURATION --------------------------+
| Parameter   | Value                                                          |
+-------------+----------------------------------------------------------------+
| Host Name   | &lt;server_host_name&gt;                                             |
| IP Address  | &lt;server_ip_address&gt;                                            |
| Admin State | &lt;admin_state&gt;                                                  |
| Oper State  | &lt;server_oper_state&gt;                                            |
| Auth Key ID | &lt;server_auth_key_id&gt;                                           |
| Config State| &lt;server_config_state&gt;                                          |
| Server State| &lt;server_state&gt;                                                 |
|  Condition  | &lt;server_condition&gt;                                             |
|  Auth State | &lt;server_auth_state&gt;                                            |
|  Offset (ms)| &lt;server_offset&gt;                                                |
+-------------+----------------------------------------------------------------+
</pre>
---

##### Unit

Link to GitHub : [saos6-unit](https://github.com/FRINXio/cli-units/tree/master/saos/saos-6/saos-6-system)

### Ciena SAOS 8

#### CLI

---
<pre>
SAOS8&gt;ntp client show keys

+- NTP AUTHENTICATION KEYS -+
| Key ID      | Type        |
+-------------+-------------+
| &lt;key_id&gt;    | &lt;key_type&gt;  |
+-------------+-------------+

SAOS8&gt;ntp client show

+------------------------- NTP CLIENT STATE -------------------------+
| Parameter              | Value                                     |
+------------------------+-------------------------------------------+
|                        |                                           |
+------------------------+-------------------------------------------+


+---------------------------------------------------- NTP SERVER CONFIGURATION ----------------------------------------------------+
|                                         |                      | Auth |  Config   |Admin|Oper |Server| Server |Auth | Offset     |
| IP Address                              | Host Name            |Key ID|  State    |State|State|State |  Cond  |State|  (ms)      |
+-----------------------------------------+----------------------+------+-----------+-----+-----+------+--------+-----+------------+
|&lt;server_address&gt;                         |                      |      |           |     |     |      |        |     |            |
+-----------------------------------------+----------------------+------+-----------+-----+-----+------+--------+-----+------------+

+- NTP AUTHENTICATION KEYS -+
| Key ID      | Type        |
+-------------+-------------+
|             |             |
+-------------+-------------+


+-------------------------- NTP MULTICAST ADDRESSES ---------------------------+
|                                                                              |
+------------------------------------------------------------------------------+

SAOS8&gt;ntp client show server &lt;server_address&gt;

+----------------------- NTP CLIENT SERVER CONFIGURATION ----------------------+
| Parameter   | Value                                                          |
+-------------+----------------------------------------------------------------+
| Index       | &lt;server_index&gt;                                                 |
| Host Name   | &lt;server_host_name&gt;                                             |
| IP Address  | &lt;server_ip_address&gt;                                            |
| Admin State | &lt;admin_state&gt;                                                  |
| Oper State  | &lt;server_oper_state&gt;                                            |
| Auth Key ID | &lt;server_auth_key_id&gt;                                           |
| Config State| &lt;server_config_state&gt;                                          |
| Server State| &lt;server_state&gt;                                                 |
|  Condition  | &lt;server_condition&gt;                                             |
|  Auth State | &lt;server_auth_state&gt;                                            |
|  Offset (ms)| &lt;server_offset&gt;                                                |
| Stratum     | &lt;server_stratum&gt;                                               |
+-------------+----------------------------------------------------------------+
</pre>
---

##### Unit

Link to GitHub : [saos8-unit](https://github.com/FRINXio/cli-units/tree/master/saos/saos-6/saos-8-system)