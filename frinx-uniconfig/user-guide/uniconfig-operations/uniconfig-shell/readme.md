# UniConfig Shell

UniConfig shell is a command-line interface for Uniconfig. Accessible over SSH, it allows users to interact with Uniconfig features including the following:

* Reading operational data of devices
* Manipulating device configuration
* Manipulating configuration templates
* Manipulating data stored in Unistore
* Invoking device or UniConfig operations
* Manipulating global UniConfig settings

As Uniconfig shell is model-driven, its interface is mostly auto-generated from YANG schemas (e.g., tree structure of data-nodes or available
RPC/action operations).

## Configuration

By default, UniConfig shell is disabled. To enable it, the configuration parameter 'cliShell/sshServer/enabled' must be set to 'true'
in the 'config/lighty-uniconfig-config.json' file.

All available settings and descriptions are displayed in the following snippet.

```properties UniConfig shell configuration (config/application.properties)
# CLI shell config
cli-shell.default-unistore-node-id=system
cli-shell.enable-scrolling=false
cli-shell.history-size=500
cli-shell.history-file-size=1000
cli-shell.ssh-server.enabled=false
cli-shell.ssh-server.port=2022
cli-shell.ssh-server.inet-address=127.0.0.1
cli-shell.ssh-server.username-password-auth.username=admin
cli-shell.ssh-server.username-password-auth.password=secret
```

After starting UniConfig, the SSH server will listen for connections on port 2022 and loopback interface.

## Navigating in the shell

* Every command line starts with a command prompt that ends with the '>' character. The identifier of the command prompt changes
  based on the current shell mode and the state of the execution in this mode.
* The commands 'exit' and 'quit' appear in all shell modes. The 'exit' command returns the state to the parent state, 'quit'
  returns the state to the nearest parent mode (e.g., configuration mode, root mode, operational show mode). If the current
  state of the shell represents some mode, 'quit' and 'exit' have the same effect - returning to the parent mode.
* Typed commands can be sent to the UniConfig using the ENTER key. After that, UniConfig processes the command and may
  send a response to the console depending on the command behaviour. All commands are processed synchronously - a user 
  cannot execute multiple commands in parallel in the same SSH session.
* CTRL-A and CTRL-E move the cursor to the beginning or end of the current line.
* CTRL-L clears the shell screen.
* Arrow keys UP/DOWN are used to load previous commands in the command history.
* CTRL+C cancels the current line and moves to a new blank line.
* The TAB key can be used to load suggestions in the current context. Hit TAB again to navigate
  through suggested commands using the arrow keys and select some of them using ENTER. Submode with suggestions
  can be left with the shortcut CTRL-E. The text in the brackets contains a description of the next command.

```shell Loading available suggestions in 'uniconfig-topology-vnf21>' under 'show' command
uniconfig-topology-vnf21>show 
>                                                (output to file)   interfaces                             (Interfaces configuration)
SNMP-NOTIFICATION-MIB                                               nacm               (Parameters for NETCONF Access Control Model.)
SNMP-TARGET-MIB                                                     ntp                                           (NTP configuration)
SNMP-VIEW-BASED-ACM-MIB                                             redundancy                             (Redundancy Configuration)
aaa                                              (AAA management)   service-node-groups (Service Node Gateway Services Configuration)
alarms                                      (Alarm configuration)   snmp    (Simple Network Management Protocol (SNMP) configuration)
alias                                     (Create command alias.)   system                      (System configuration and statistics)
confdConfig                                (ConfD configuration.)   |                                                          (pipe)
event                                             (Event scripts)
```

* If the displayed output is longer than the length of the command-line window, the output is displayed with scrolling 
  capability. Use ENTER to display the next line and SPACE to display the next page. Use the 'q' key
  to leave scrolling mode. You can only scroll only in one direction - towards the end of the output.

![Scrolling through long output](scrolling_example.png)

## Root mode

* Root mode represents initial mode that is available to a user after successful authentication.
* Example: login into UniConfig shell:

```shell Connecting to UniConfig shell using SSH client
Connection to 127.0.0.1 closed.
[jtoth@JT-WORK ~]$ ssh admin@127.0.0.1 -p 2022
Password authentication
(admin@127.0.0.1) Password:
uniconfig>
```

```shell Root mode overview
uniconfig>
configuration-mode      (opening configuration mode)
exit
show                      (reading data from device)
show-history (show history [max number of commands])
```

* Command 'exit' is used for exiting UniConfig shell interface altogether (disconnecting SSH client).
* Example - exiting UniConfig shell:

```shell Leaving UniConfig shell
uniconfig>exit
Console closed. Press any key to exit!
Connection to 127.0.0.1 closed by remote host.
Connection to 127.0.0.1 closed.
```

!!!
Currently, only username/password single-user authentication is supported according to configuration
in the 'application.properties'.
!!!

### Accessing sub-modes

* Root mode acts as a gateway for opening configuration and show modes.
* Example - switching into Configuration mode:

```shell Opening configuration mode
uniconfig>configuration-mode
config>
```

### Show command history

* Command 'show-history' is used for displaying list of N last invoked commands.
* Example - show executed last 5 commands:

```shell Show history
config>show-history 5
----- History of commands -----
10-05-2022 14:48:14 : configuration-mode
10-05-2022 14:48:16 : request
10-05-2022 14:48:17 : exitr
10-05-2022 14:48:18 : exit
10-05-2022 14:48:24 : show-history 5
```

* This command is also available from the Configuration mode.

!!!
List of invoked commands are persisted across UniConfig restarts and SSH connections.
!!!

## Configuration mode

* Configuration mode provides access to:
  
1. CRUD operations on top of persisted uniconfig, unistore and template nodes.
2. CRUD operations on top of persisted UniConfig settings.
3. UniConfig RPC operations such as commit or calculate-diff.

* After opening Configuration mode, a new UniConfig transaction is created. All operations invoked from
  the configuration mode are executed in the scope of the created transaction.
* The transaction is automatically closed after leaving the Configuration mode ('exit' or 'quit' command).
* If 'commit' or 'checked-commit' is invoked, the transaction is automatically refreshed (the user stays in configuration
  mode with a newly created transaction).

```shell Configuration mode overview
config>
others
callbacks                           (operations on callbacks)
exit                                  (return to parent mode)
quit                                    (return to root mode)
request                                   (execution of RPCs)
settings                             (operations on settings)
show-history          (show history [max number of commands])
template-topology       (operations on the template topology)
uniconfig-topology     (operations on the uniconfig topology)
unistore-topology       (operations on the unistore topology)
aliases
diff (alias for 'request calculate-diff target-nodes/node *')
```

Commands like SET / SHOW / DELETE are now available only on a specific device and are not accessible in root configuration mode.

```shell set / show / delete commands overview
config>uniconfig-topology test-node-1
uniconfig-topology-test-node-1>
SNMP-NOTIFICATION-MIB                                               nacm               (Parameters for NETCONF Access Control Model.)
SNMP-TARGET-MIB                                                     ntp                                           (NTP configuration)
SNMP-VIEW-BASED-ACM-MIB                                             quit                                        (return to root mode)
aaa                                              (AAA management)   redundancy                             (Redundancy Configuration)
alarms                                      (Alarm configuration)   service-node-groups (Service Node Gateway Services Configuration)
alias                                     (Create command alias.)   set                                               (set operation)
confdConfig                                (ConfD configuration.)   show                                  (show data in current path)
delete                                         (delete operation)   show-history              (show history [max number of commands])
event                                             (Event scripts)   snmp    (Simple Network Management Protocol (SNMP) configuration)
exit                                      (return to parent mode)   system                      (System configuration and statistics)
interfaces                             (Interfaces configuration)
```

### Show configuration

* Show operation can be used to display selected subtrees.
* Subtree path can be constructed interactively with help of shell suggestions / auto-completion mechanism.
  Construction of the path works the same way for SET / SHOW/ DELETE operations.

  
* Example - displaying the configuration of a selected container:

1. The user must first go into a specific topology on a specific device:
```shell move to a specific topology
config>uniconfig-topology
nodes
test-node-1   test-node-2
```

```shell move to a specific device
config>uniconfig-topology test-node-1
uniconfig-topology-test-node-1>
```

2. After this, the show operation is available:

```shell Show operation: selection of root data container
uniconfig-topology-test-node-1>show 
>                                                (output to file)   interfaces                             (Interfaces configuration)
SNMP-NOTIFICATION-MIB                                               nacm               (Parameters for NETCONF Access Control Model.)
SNMP-TARGET-MIB                                                     ntp                                           (NTP configuration)
SNMP-VIEW-BASED-ACM-MIB                                             redundancy                             (Redundancy Configuration)
aaa                                              (AAA management)   service-node-groups (Service Node Gateway Services Configuration)
alarms                                      (Alarm configuration)   snmp    (Simple Network Management Protocol (SNMP) configuration)
alias                                     (Create command alias.)   system                      (System configuration and statistics)
confdConfig                                (ConfD configuration.)   |                                                          (pipe)
event                                             (Event scripts)
```

```shell Show operation: selection of a specific virtual network interface 
uniconfig-topology-test-node-1>show interfaces vni 
> (output to file)   vni-0/4              vni-0/6              vni-0/8              |           (pipe)
vni-0/10             vni-0/5              vni-0/7              vni-0/9
```

```shell Show operation: invocation of a command
uniconfig-topology-test-node-1>show interfaces vni vni-0/10 
{
  "name": "vni-0/10",
  "ether-options": {
    "link-mode": "auto",
    "link-speed": "10m"
  },
  "description": "sample description",
  "enable": true
}
```

### Delete configuration

* Delete operation removes a selected subtree.
* Example - removing a container:

1. The user must first go into a specific topology on a specific device:
```shell move to a specific topology
config>uniconfig-topology
nodes
test-node-1   test-node-2
```

```shell move to a specific device
config>uniconfig-topology test-node-1
uniconfig-topology-test-node-1>
```

2. After this, the delete operation is available:

```shell Construction of path with help from suggestions
uniconfig-topology-test-node-1>delete 
SNMP-NOTIFICATION-MIB                                               interfaces                             (Interfaces configuration)
SNMP-TARGET-MIB                                                     nacm               (Parameters for NETCONF Access Control Model.)
SNMP-VIEW-BASED-ACM-MIB                                             ntp                                           (NTP configuration)
aaa                                              (AAA management)   redundancy                             (Redundancy Configuration)
alarms                                      (Alarm configuration)   service-node-groups (Service Node Gateway Services Configuration)
alias                                     (Create command alias.)   snmp    (Simple Network Management Protocol (SNMP) configuration)
confdConfig                                (ConfD configuration.)   system                      (System configuration and statistics)
event                                             (Event scripts)
```

```shell Delete 'ether-options' container under 'vni' with key value 'vni-0/10'
uniconfig-topology-test-node-1>delete interfaces vni vni-0/10 ether-options
uniconfig-topology-test-node-1>
```

3. The user must quit to configuration mode, commit using request mode and return to the device on the topology:

```shell Verify state of 'network-instance'
uniconfig-topology-test-node-1>show interfaces vni vni-0/10 
{
  "name": "vni-0/10",
  "description": "sample description",
  "enable": true
}
```

### Set configuration

* Set operation can be used for:

1. Setting the value of a single leaf.
2. Setting values of multiple leaves in a single shell operation.
3. Setting a list of values for a leaf-list.
4. Replacing the whole subtree using a JSON snippet.

* Example - setting the value of a single leaf:
```shell move to specified device
config>uniconfig-topology iosxr
```

```shell Providing datatype hints at selected leaf
uniconfig-topology-iosxr>set lacp config system-priority
(type: uint16, constraints: [Range: [[0..65535]]])
```

```shell Setting value of LACP 'system-priority' to '100'
uniconfig-topology-iosxr>set lacp config system-priority 100
uniconfig-topology-iosxr>
```

```shell Displaying changed LACP configuration 
uniconfig-topology-iosxr>show lacp config
{
  "system-priority": 100
}
```

* Example - setting values of multiple leaves: under 'hold-time' container:
```shell move to specified device
config>uniconfig-topology iosxr
```

```shell Displaying hint for value of the leaf 'up'
uniconfig-topology-iosxr>set interfaces interface GigabitEthernet0/0/0/0 hold-time config up
(type: uint32, constraints: [Range: [[0..4294967295]]])
```

```shell Setting value of the leaf 'up' and displaying hint for value of the leaf 'down'
uniconfig-topology-iosxr>set interfaces interface GigabitEthernet0/0/0/0 hold-time config up 20 down
(type: uint32, constraints: [Range: [[0..4294967295]]])
```

```shell Setting values of the leaves 'up' and 'down'
uniconfig-topology-iosxr>set interfaces interface GigabitEthernet0/0/0/0 hold-time config up 20 down 15
uniconfig-topology-iosxr>
```

```shell Verification of the 'hold-time' configuration
uniconfig-topology-iosxr>show uniconfig iosxr interfaces interface GigabitEthernet0/0/0/0 hold-time
{
  "config": {
    "up": 20,
    "down": 15
  }
}
```

* JSON snippet can be written to a selected data-tree node by entering 'json' sub-mode. In the 'json' su-mode, user can type
  multiple lines that must represent a well-formed JSON document. At the end, user can confirm the set operation 
  using pattern 'w!' + newline or to cancel the set operation with 'q!' + newline pattern.
* Example - replacing configuration of an interface using a JSON snippet:

```shell move to specified device
config>uniconfig-topology iosxr
```

```shell Replacing 'config' container under interface using provided JSON snippet
uniconfig-topology-iosxr>set interfaces interface GigabitEthernet0/0/0/1 config json
{
>   "config": {
>     "type": "iana-if-type:ethernetCsmacd",
>     "enabled": true,
>     "name": "GigabitEthernet0/0/0/1"
>   }
> }
w!
```

```shell Verification of Set operation
uniconfig-topology-iosxr>show interfaces interface GigabitEthernet0/0/0/1
{
  "name": "GigabitEthernet0/0/0/1",
    "config": {
    "type": "iana-if-type:ethernetCsmacd",
    "enabled": true,
    "name": "GigabitEthernet0/0/0/1"
  }
}
```

* Example - leaving 'json' sub-mode without execution of Set operation:

```shell Cancellation of the Set operation and leaving 'json' sub-mode
uniconfig-topology-iosxr>set interfaces interface GigabitEthernet0/0/0/1 config json
{
>   "config": {
>     "type": "iana-if-type:ethernetCsmacd",
>     "enabled": true,
>     "name": "GigabitEthernet0/0/0/1"
>   }
> }
q!
```

```shell Verification of the cancelled Set operation
uniconfig-topology-iosxr>show interfaces interface GigabitEthernet0/0/0/1
{
  "name": "GigabitEthernet0/0/0/1",
  "config": {
    "type": "iana-if-type:ethernetCsmacd",
    "enabled": false,
    "name": "GigabitEthernet0/0/0/1"
  }
}
```

### Execute UniConfig operation

* Command 'request' is used to execute UniConfig operations such as 'commit' or 'calculate-diff'
  in the UniConfig transaction.
* The command is available in configuration-mode.
* User can fill in input parameters and values interactively or via provided JSON snippet.

- Example - execution of UniConfig RPCs in the scope of open UniConfig transaction:

```shell Displaying available 'commit' RPC parameters
config>request commit
>                                                                            (output to file)
do-rollback (Controls whether to roll back successfully configured devices in case of failu…)
do-validate (Option to enable/disable validation at commit. Default value is true - validate)
json                                                                             (JSON input)
target-nodes/node
|                                                                                      (pipe)
```

```shell Execution of 'calculate-diff' RPC with 1 argument - target node
config>request calculate-diff target-nodes/node iosxr
{
  "node-results": {
    "node-result": [
      {
        "node-id": "iosxr",
        "status": "complete",
        "created-data": [
          {
            "path": "/network-topology:network-topology/topology=uniconfig/node=iosxr/frinx-uniconfig-topology:configuration/frinx-openconfig-system:system",
            "data": "{
              "frinx-openconfig-system:system": {
                "frinx-huawei-global-config-extension:banner": {
                  "config": {
                    "banner-text": "Test banner"
                  }
                }
              }
            }"
          }
        ]
      }
    ]
  },
  "overall-status": "complete"
}
[24.04.2023, 09:25:31]
```

```shell Displaying available 'sync-from-network' RPC paramaters:
config>request sync-from-network
>                                                                            (output to file)
check-timestamp (Perform timestamp comparison(last known to Uniconfig vs current timestamp …)
json                                                                             (JSON input)
target-nodes/node
|                                                                                      (pipe)
```

```shell Execution of 'sync-from-network' RPC with 2 arguments - target node and 'check-timestamp' flag
config>request sync-from-network check-timestamp true target-nodes/node iosxr
{
  "node-results": {
    "node-result": [
      {
        "node-id": "iosxr",
        "status": "complete"
      }
    ]
  },
  "overall-status": "complete"
}
[24.04.2023, 09:26:48]
```

## Request operational mode

This command has been merged with request configuration mode and is now only available 
in configuration-mode.

* Request mode allows users to:

1. Invoke selected UniConfig requests that read or alter UniConfig settings.
2. Invoke RPCs or actions that are provided by network devices or other southbound mount-points.

* The user can fill in input parameters and values interactively or via a provided JSON snippet.
* The transaction is passed from configuration-mode.
- Example - invocation of RPC 'execute-and-read' with typed input parameters:

```shell Displaying available RPCs provided by device 'iosxr'
request>cli iosxr
operations
clear-journal
execute (Simple execution of single or multiple commands on remote terminal. Multiple comma…)
execute-and-expect (Form of the 'execute-and-read' RPC that can contain 'expect(..)' patter…)
execute-and-read (Execution of the sequence of commands specified in the input. These comma…)
execute-and-read-until
read-journal
```

```shell Displaying available 'execute-and-read' RPC parameters
request>cli iosxr execute-and-read
>                                                                            (output to file)
command        (Input configuration snippet (one or multiple commands separated by newline).)
json                                                                             (JSON input)
wait-for-output-timer (If no output is received during this time, then execute next command…)
|                                                                                      (pipe)
```

```shell Execution of 'execute-and-read' RPC with two arguments - 'wait-for-output-timer' and 'command'
request>cli iosxr execute-and-read wait-for-output-timer 2 command "show users"
{
   "output": "Mon May 16 07:28:30.405 UTC
   Line            User                 Service  Conns   Idle        Location
*  vty0            cisco                ssh          0  00:00:00     192.168.1.42"
}
[24.04.2023, 09:34:21]
```

- Example - execution of the same RPC 'execute-and-read' using input JSON:

```shell Execution of 'execute-and-read' RPC with input JSON snippet:
request>cli iosxr execute-and-read json
  {
>     "input": {
>         "command": "show users",
>         "wait-for-output-timer": 2
>     }
> }
w!
{
   "output": "Mon May 16 07:37:55.256 UTC
   Line            User                 Service  Conns   Idle        Location
*  vty0            cisco                ssh          0  00:00:00     192.168.1.42"
}
[24.04.2023, 09:36:48]
```

!!!
UniConfig shell does not support interactive typing of input arguments for an RPC/action that contains the 'list' YANG element.
Such operations must be executed using input JSON.
!!!

## Show operational mode

* Show mode allows users to:

1. Display operational data of UniConfig itself - e.g., logging status, list of open transactions, or list of acquired
   subscriptions.
2. Display operational data of network devices.

```shell Overview of Show operational mode
show>
others
cli                    (reading data from CLI device)
exit                          (return to parent mode)
logging-status               (reading logging status)
netconf            (reading data from NETCONF device)
netconf-subscriptions (reading netconf subscriptions)
notifications                 (reading notifications)
quit                            (return to root mode)
show-history  (show history [max number of commands])
snapshots-metadata       (reading snapshots metadata)
transaction-log             (reading transaction log)
transactions               (reading transaction data)
aliases
lbr      (alias for 'logging-status broker restconf')
```


* After opening Show mode, a new UniConfig transaction is opened. The transaction is closed after leaving this mode.


```shell Opening Show operational mode
uniconfig>show
show>
```

- Example - displaying configuration of selected subtree:

```shell Display configuration of GigabitEthernet0/0/0/0 interface
show>cli iosxr interfaces(frinx-openconfig-interfaces) interface GigabitEthernet0/0/0/0
{
  "name": "GigabitEthernet0/0/0/0",
  "config": {
    "type": "iana-if-type:ethernetCsmacd",
    "enabled": false,
    "name": "GigabitEthernet0/0/0/0"
  }
}
```

- Example - displaying selected system configuration:

```shell Display list of open UniConfig transactions
show>transactions transaction-data
[
  {
    "transaction-id": "5d9c8819-5b05-4c7a-b7e5-3c84478aeeb0",
    "idle-timeout": 300,
    "last-access-time": "2022-May-16 07:02:31.501 +0000",
    "hard-timeout": 1800,
    "creation-time": "2022-May-16 07:02:31.501 +0000"
  },
  {
    "transaction-id": "80091b4b-5432-41cd-9277-1b18ae77b45f",
    "idle-timeout": 300,
    "last-access-time": "2022-May-16 07:02:42.747 +0000",
    "hard-timeout": 1800,
    "creation-time": "2022-May-16 07:02:42.747 +0000"
  }
]
```

## Pipe operations
UniConfig shell supports pipe operations that are similar to unix shell/bash pipes.
When a command is followed by pipe sign: |, the output of that command will be passed to a selected pipe operation.
- Example:
```shell move to specified device
config>uniconfig-topology R1
```

```shell Execution of grep pipe operation:
uniconfig-topology-R1>show interface-configurations interface-configuration | grep netmask

    "netmask": "255.255.255.0"
```

Supported pipe operations are:
1. grep - shows only lines that match supplied regex
2. match - same as grep but can be used with optional parameters to show also lines before and after matched line
3. context-match - same as grep but shows also parent structure
4. brief - displays root elements in the short table format
5. hide-empty-data-nodes - hides data nodes without any child node. 
6. hide-attributes - hides attributes of data nodes.

## Redirection of output
The output of an executed command can be redirected to a file using the ">" sign followed by a filename.
- Example

```shell move to specified device
config>uniconfig-topology R1
```

```shell Redirection of output to file
uniconfig-topology-R1>show interface-configurations interface-configuration act\ GigabitEthernet0/0/0/1 > '/home/output.txt' 
```
In this case, output in the console is empty but the content of the output.txt file is a follows:
```text Redirection output
{
  "active": "act",
  "interface-name": "GigabitEthernet0/0/0/1",
  "shutdown": [
    null
  ]
}
```

## Aliases

You can define aliases in UniConfig shell. For this purpose, there is a json file named shell-aliases in the 
UniConfig distribution. The file can be found under Uniconfig/distribution/packaging/zip/target/uniconfig-x.x.x/config 
after unpacking the UniConfig distribution. The file contains some sample aliases.

``` shell-aliases.json with default samples
/*
Example: "alias": "command1 command2 * command3 *"
Alias name must be a simple word without spaces
Asterisk symbol is a placeholder. We can dynamically add an alias value
*/
{
  "configuration-mode": {
    "diff": "request calculate-diff target-nodes/node *"
  },
  "request": {
    "shh": "show-history"
  },
  "show": {
    "lbr": "logging-status broker restconf"
  }
}
```

### Aliases creation

It is not possible to create aliases dynamically, only before Uniconfig is started. The following rules apply:

1. The alias name must be unique and cannot contain whitespaces.
2. The command can contain a wildcard (*). In this case the user will be prompted to add a value.
3. The alias is only visible in the mode where it was defined.

### Examples

- Example - execution of the alias 'diff xr5':

```
uniconfig>configuration-mode 
config>diff xr5
{
  "node-results": {
    "node-result": [
      {
        "node-id": "xr5",
        "status": "complete"
      }
    ]
  },
  "overall-status": "complete"
}
[24.04.2023, 09:31:32]
config>
```

- Example - execution of the alias 'lbr':

```
uniconfig>show
show>lbr 
{
  "broker-identifier": "restconf",
  "is-logging-broker-enabled": false
}
show>

```

- Example - execution of the alias 'shh':

```
uniconfig>request
request>show-history 
----- History of commands -----
18-05-2022 14:13:09 : show
18-05-2022 14:13:18 : lbr
18-05-2022 14:17:43 : exit
18-05-2022 14:17:48 : request
18-05-2022 14:17:57 : shcs
18-05-2022 14:18:10 : shcs n1
18-05-2022 14:18:25 : show-history
request>

```

## Callbacks

Callbacks include sending POST and GET requests to the remote server and invoking user scripts from the UniConfig shell.

The following is required to use callbacks:

1. Necessary YANG modules - YANG modules that are required by the callbacks.
2. Configuration - Enable callbacks in 'config/application.properties' and set the remote server and access token.
3. Update repository - Add the necessary YANG modules from step 1 into at least one YANG repository in the cache
directory, and either define remote endpoints and scripts in a YANG file or create a new one for callbacks. For definition of 
remote endpoints, use the 'frinx-callpoint@2022-06-22.yang' extension.
4. UniStore node - Create a UniStore node using the YANG repository containing the necessary YANG modules 
from step 1 and a YANG file with defined endpoints and scripts.

!!!
Step 4 is optional in UniConfig shell, as UniConfig creates dummy UniStore nodes for all repositories 
that meet the conditions in step 3. In this case, the dummy UniStore node name is identical to the YANG repository name. In 
RestConf, step 4 is mandatory.
!!!

### Necessary YANG modules

The following YANG modules are required:

* frinx-callpoint@2022-06-22.yang (not needed for scripts)
* tailf-common@2018-11-12.yang
* tailf-meta-extensions@2017-03-08.yang
* tailf-cli-extensions@2018-09-15.yang

### Configuration

By default, callbacks are disabled and the host and port for the remote server are empty in 'config/lighty-uniconfig-config.json'. 
To enable callbacks, the configuration parameter 'callbacks/enabled' must be set to 'true'. It is also necessary to set the host and port 
for the remote server and store an access token in the UniConfig database. 

The host and port for the remote server can be set in three ways:

1. Before starting Uniconfig, in the 'config/application.properties' file. The port number is optional:

```properties UniConfig callbacks configuration (config/application.proprties)
# Callbacks config
callbacks.enabled=true
callbacks.remote-server.host=127.0.0.1
callbacks.remote-server.port=8443
```

2. After starting UniConfig, with a PUT request:

```update remote server by PUT request
  curl --location --request PUT 'http://127.0.0.1:8181/rests/data/callbacks:callbacks-settings' \
  --header 'Accept: application/json' \
  --header 'Authorization: Basic YWRtaW46YWRtaW4=' \
  --header 'Content-Type: application/json' \
  --data-raw '{
      "callbacks-settings": {
          "remote-server": {
              "host": "127.0.0.5",
              "port": 9000
          }
      }
  }'
```

3. After starting UniConfig, with cli-shell:

```update remote server by cli-shell
  uniconfig>configuration-mode 
  config>set settings callbacks-settings remote-server host 127.0.0.5 port 9000
  config>request commit 
```

The access token can be stored in the UniConfig database in two ways:

1. After starting UniConfig, with a PUT request:

```update access token by PUT request
  curl --location --request PUT 'http://127.0.0.1:8181/rests/data/callbacks:callbacks-settings/access-token' \
  --header 'Accept: application/json' \
  --header 'Authorization: Basic YWRtaW46YWRtaW4=' \
  --header 'Content-Type: application/json' \
  --data-raw '{
      "access-token": "token"
  }'
```

2. After starting UniConfig, with cli-shell:

```update access token by cli-shell
  uniconfig>configuration-mode 
  config>set settings callbacks-settings access-token token
  config>request commit
```

Available settings and descriptions for callbacks are displayed in the following snippet.

```properties UniConfig callbacks configuration (config/application.proprties)
# Callbacks config
callbacks.enabled=true
callbacks.remote-server.host=127.0.0.1
callbacks.remote-server.port=8443
```

### Update repository

First, create or update the YANG repository by using the 'frinx-callpoint@2022-06-22.yang' extension 
displayed in the following snippet. There is only one extension, 'url', with the argument 'point'.

``` frinx-callpoint@2022-06-22.yang
module frinx-callpoint {
    yang-version 1.1;
    namespace "http://frinx.io/callpoint";
    prefix callpoint;

    revision 2022-06-22 {
        description "Initial revision";
    }

    extension url {
        argument point;
    }
}
```

#### Add call-point (GET request)

The following snippet shows how to create a call-point in the 'frinx-test' YANG file by using the 
'frinx-callpoint@2022-06-22.yang' extension.

``` example of using of the frinx-callpoint@2022-06-22.yang in YANG file
module frinx-test {
    yang-version 1.1;
    namespace "http://frinx.io/frinx-test";

    import frinx-callpoint { prefix "fcal"; }

    container test {
        container get-request {
            fcal:url /data/from/remote;
        }
    }
```

The argument of the 'url' extension is '/data/from/remote', which is appended to the end of the remote server URI 
configured in 'config/lighty-uniconfig-config.json'. Thus the final address for the remote call-point is 
'https://remote.server.io/data/from/remote'.

#### Add action (POST request)

The following snippet shows how to create an action in the 'frinx-test' YANG file by using the
'frinx-callpoint@2022-06-22.yang' extension. You must also import 'tailf-common.yang'.

The action consists of:

1. The action name, defined by 'tailf:action'.
2. The suffix for the remote endpoint, defined by 'fcal:url'.
3. The input that contains body of the request. This part is optional.

``` example of using frinx-callpoint@2022-06-22.yang in YANG file
module frinx-test {
    yang-version 1.1;
    namespace "http://frinx.io/frinx-test";

    import frinx-callpoint { prefix "fcal"; }
    import tailf-common { prefix "tailf"; }

    container post-request {
        tailf:action test-action {
            fcal:url /invoke/remote/test-action;
            input {
                container body {
                    leaf data {
                        type string;
                    }
                }
            }
        }
    }
```

#### Add script

The following snippet shows how to create a script in the 'frinx-test' YANG file by using
'tailf-common.yang'. It is not required to import the 'frinx-callpoint@2022-06-22.yang' extension.

The script consists of:

1. The script name, defined by 'tailf:action'.
2. The path to the script, defined by 'tailf:exec'.
3. Arguments for the script, defined by 'tailf:exec'.

Arguments can be dynamic (i.e., the user can pass values to them) or static (flags). Follow these conventions 
when creating arguments:

1. Each argument must contain a name (for example, -n, -j).
2. Dynamic arguments must be enclosed in '$(...)' (for example, '$(name)').
3. Flags are simple words without whitespace. (for example, VIP, UPPER, upper).

``` example of using frinx-callpoint@2022-06-22.yang in YANG file
module frinx-test {
    yang-version 1.1;
    namespace "http://frinx.io/frinx-test";

    import tailf-common { prefix "tailf"; }

    container script {
        tailf:action test-script {
            tailf:exec '/tmp/test_script.sh' {
                tailf:args '-n $(name) -j $(job) -v VIP';
            }
        }
    }
```

### UniStore node


A UniStore node can be created by RestConf or UniConfig shell. If a repository is explicitly defined by the query 
parameter '?uniconfig-schema-repository=repository-name', this repository must contain all necessary YANG 
modules. If a repository name is not defined when the UniStore node is created, all necessary YANG modules 
must be in the 'latest' schema repository.

### Examples

- Example - callpoint invocation in the shell:

``` callpoint invocation
config>callbacks repository-name
callbacks-repository-name>show test get-request
{
  "response": {
    "value": "some-value"
  }
}
callbacks-repository-name>
```

- Example - action invocation in the shell:

``` action invocation
config>request 
request>callbacks repository-name post-request test-action body data "some-data"
{
  "response": {
    "value": "some-data was processed"
  }
}
request>
```

- Example - user script execution in the shell:

``` user script execution
config>request 
request>callbacks repository-name script test-script /tmp/test_script.sh 
VIP    job    name
request>callbacks repository-name script test-script /tmp/test_script.sh job "FRINX" 
VIP    name
request>callbacks repository-name test-script /tmp/test_script.sh job "FRINX" VIP
Name: 
Job: Frinx
is VIP

Exit code: 0
request>
```
