# Uniconfig 5.0.13 Release Notes 
 
## :white_check_mark: New Features 
 
 - Add jsonb-filter in UC client
 
 - Automation of adding release notes to documetation
 
 - API for bulk addition of templates
 
 - Implementation of callbacks
 
 - Implementation of publishing shell notifications to kafka
 
 - JSONB filtering core
 
 - Upgrade-from-network as part of sync-from-network
 
## :x: Bug Fixes 
 
 - Cancellation of initial NETCONF RPCs after request timeout
 
 - Fixed parsing XML-endoded leaf with instance-identifier to list
 
 - Fixed synchronization of notification listeners
 
 - Releasing subscription that is bound to tangling mountpoint
 
 - Fixed construction of output with set with-defaults param
 
 - Fix gnmi unknown augmentations
 
## :bulb: Improvements 
 
 - Implementing HideAttributes query-parameter per request. - Introduced query parameter HidesAttribute. Default value is 'false'.  Hides all composite data-tree nodes attributes to the GET response.
 
 - Stop acquiring subscription that was released in the same iteration
 
 - Fixed and refactored DOMMountPointService implementation
 
 - Add support for template leaf hashing
 
 - Improved code and API of create-multiple-templates RPC
 
 - Implemented frinx-types:json-element in the JSON deserializer
 
 - Swagger - Grouping requests
 
 - Swagger - Remove patch operation
 
 - Bump Mockito and get rid of Powermock
 
 - Bump Mockito and get rid of Powermock
 
 - Swagger: inclusion of action endpoints
 
 - YangPackager does not catch broken submodules
 
 - Refresh schema context for netconf southbound if device was upgraded
 
 - Make mountpoint service call listeners from different thread
 
