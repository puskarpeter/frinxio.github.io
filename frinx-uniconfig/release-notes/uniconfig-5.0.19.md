# Uniconfig 5.0.19 Release Notes 
 
## :white_check_mark: New Features 
 
 - Fixed hardcoded part and added one more if condition to receiver transceiver data for IOS-XE (#493)
 
 - Stable XR6 XR66 devices (#471)
 
 - Implementation of storing failed installations into DB (stable 5.0.x)
 
 - Implemented TU for adding/removing users for Saos6 (#438)
 
 - Implemented TU for collecting transceiver information for IOS-XE (#439)
 
## :x: Bug Fixes 
 
 - Downgraded sshd to 2.8.0
 
 - Fix uninstall -> install transition
 
 - Swagger: fix generation of operational APIs (5.0.X)
 
 - Fix CVEs
 
 - Fixed reading public key from NETCONF device (NPE)
 
 - Fixed distribution of mount failure from GNMi layer
 
 - Swagger: Fix path filtering
 
## :bulb: Improvements 
 
 - expose gnmi parameters
 
 - add overallStatus to multiple-nodes-rpc-output
 
 - Improved error message when connection cannot be created
 
 - Exposed DOMMountPointService configuration
 
 - Optimization of mountpoint notifications
 
 - Added logs into DOM Mountpoint Service
 
## :wrench: Other 
 
 - Configurable re-sending cli commands
 
 - Fixed mount point creation for CLI topology
 
 - Removed unified-topology.yang
 
 - Refactored unified layer and mounting/unmounting process - updates
 
 - Refactored unified layer and mounting/unmounting process
 
 - Added logging level for shell to the logback.xml
 
