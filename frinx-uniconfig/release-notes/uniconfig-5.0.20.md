# Uniconfig 5.0.20 Release Notes 
 
## :white_check_mark: New Features 
 
 - Support for GetInstalledNodes in UC client - 5.0.x
 
 - Add getJSONOutput to UniConfig client
 
 - Added some commands for collecting data for IOS-XE (#515)
 
 - Skip unreachable nodes at commit
 
## :x: Bug Fixes 
 
 - Fixed leafref version-drop
 
 - Suppress Netty FP CVEs
 
 - Fixed quit command in the shell
 
 - Fixed pattern handling and XPath extension parsing
 
 - Fixed parsing of seconds in XR native metadata unit
 
 - Swagger: fix generation of action nodes (5.0.X)
 
 - Swagger: fix no key lists generation (5.0.X)
 
 - Fixed locking of nodes from TX with enabled dedicated sessions (#523)
 
 - Fix bug in bulk edit operation
 
 - Swagger: fix generation of operation children from config container
 
## :bulb: Improvements 
 
 - Change overallStatus when skiping unreachable nodes
 
 - handle user parameters input in GnmiDefaultParametersService
 
 - Removed 'reconcile' mountpoint parameter (#572)
 
 -  Disable verification of supported query parameters (5.0.x) (#549)
 
 - Swagger: toggle generation of POST apis for containers
 
 - Bulk-edit rpc improvements
 
## :wrench: Other 
 
 - Swagger: fix npe in custom operational path (5.0.X)
 
 - Added only-vlan parser, upgraded trunk-vlans for huawei (#528)
 
 - Callbacks authentication
 
