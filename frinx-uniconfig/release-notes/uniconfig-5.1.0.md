# Uniconfig 5.1.0 Release Notes 
 
## :white_check_mark: New Features 
 
 - Support for GetInstalledNodes in UC client
 
 - Add getJSONOutput to UniConfig client
 
 - Added some commands for collecting data for IOS-XE (#527)
 
 - Skip unreachable nodes at commit
 
 - Fixed hardcoded part and added one more if condition to receiver transceiver data for IOS-XE (#490)
 
 -  added implementation of XR6 and XR6.6 devices as native units
 
 - Implementation of storing failed installations into DB (main)
 
 - Implemented TU for adding/removing users for Saos6 (#360)
 
 - Implemented TU for collecting transceiver information for IOS-XE (#437)
 
 - Implemented TU for collecting all the information in NTP MCS for Saos6 and Saos8 (#352)
 
 - Implemented low priority fields for collecting inventory for SAOS6 CEN(ring) (#341)
 
## :x: Bug Fixes 
 
 - Fixed synchronization in datastore transaction
 
 - Stop reporting metrics into log/logs.log and stdout (#598)
 
 - Fixed reconcile SQL migration file
 
 - Fix CVE-2021-37533
 
 - Add migration for removing node-extension:reconcile
 
 - Fixed leafref version-drop
 
 - Suppress Netty FP CVEs
 
 - Fixed quit command in the shell
 
 - Fixed pattern handling and XPath extension parsing
 
 - Fixed parsing of seconds in XR native metadata unit
 
 - Swagger: fix generation of action nodes
 
 - Swagger: fix no key lists generation
 
 - Fixed locking of nodes from TX with enabled dedicated sessions (#522)
 
 - Fix bug in bulk edit operation
 
 - Swagger: fix generation of operation children from config container
 
 - Downgraded sshd to 2.8.0
 
 - Fix uninstall -> install transition
 
 - Fix : bad package for GnmiDefaultParametersService
 
 - Swagger: fix generation of operational APIs
 
 - Fixed hardcoded part and added one more if condition to receiver transceiver data for IOS-XE (#490)
 
 - Fix CVEs
 
 - Fixed reading public key from NETCONF device (NPE)
 
 - Fixed distribution of mount failure from GNMi layer
 
 - Swagger: Fix path filtering
 
 - Bump units versions to 5.1.0-SNAPSHOT
 
 - Swagger: Fix generation of arguments in path
 
 - Fix Logback and cleanup POMs
 
 - Fixed cleanup of existing MP during mount-node RPC
 
 - Swagger: fix generation of choice nodes
 
 - Fixed encryption of sensitive info passed via template variables (#326)
 
 - fix Jsonb filter element filtering
 
 - Swagger - Fix request generation
 
 - Fixed passing leaf-list in shell callbacks
 
## :bulb: Improvements 
 
 - Change overallStatus when skiping unreachable nodes
 
 - handle user parameters input in GnmiDefaultParametersService
 
 - Removed 'reconcile' mountpoint parameter (#573)
 
 - Disable verification of supported query parameters (5.1.x) (#550)
 
 - Swagger: toggle generation of POST apis for containers
 
 - Bulk-edit rpc improvements
 
 - expose gnmi parameters
 
 - add overallStatus to multiple-nodes-rpc-output
 
 - Improved error message when connection cannot be created
 
 - Exposed DOMMountPointService configuration
 
 - Optimization of mountpoint notifications
 
 - Added logs into DOM Mountpoint Service
 
 - Swagger: Custom operational path
 
 - Improved reporting of parsing issues in RESTCONF
 
 - Bump logback
 
 - Swagger - Improve start file
 
 - Changed order of some commands for SAOS8 (#348)
 
 - Swagger: generate augmentations in respective modules
 
 - Expose request-timeout parameter
 
 - Bump dependency-check to 7.3.0
 
 - readEntireConfig toString returns plain content
 
 - Reading mount configuration in the uniconfig-client
 
 - Swagger: generate augmentations in respective modules
 
## :wrench: Other 
 
 - Swagger: fix npe in custom operational path
 
 - Added only-vlan parser, upgraded trunk-vlans for huawei (#444)
 
 - Callbacks authentication
 
 - Configurable re-sending cli commands
 
 - Fixed mount point creation for CLI topology
 
 - Removed unified-topology.yang
 
 - Refactored unified layer and mounting/unmounting process - updates
 
 - Refactored unified layer and mounting/unmounting process
 
 - Added logging level for shell to the logback.xml
 
