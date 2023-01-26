# Uniconfig 5.0.22 Release Notes 
 
## :white_check_mark: New Features 
 
 - make replace request on correct node for gnmi
 
 - Add GetTemplateNodes RPC and add support to Client
 
 - Implemented some new commands for Huawei TU (#580)
 
## :x: Bug Fixes 
 
 - Fixed encryption of leaves marked using deviations
 
 -  Fix vulnerabilities by changing base docker image
 
 - Stop cleaning YANG repos associated to persisted nodes
 
 - Fix vulnerabilities by changing base docker image
 
 - Swagger: fix actions using custom operational path
 
 - Suppressed CVE-2021-4277 (#612)
 
 - Fix CVE-2021-37533
 
## :bulb: Improvements 
 
 - Swagger: mandatory indicator
 
 - Improved registration of unexpected YANGs downloaded from device
 
 - Add compare-config RPC.
 
 - Changed logging level: Unable to map identifier to capability
 
 - Skipping unknown fields in GET request
 
 - Added an RPC input to enable error handling for execute-and-read RPC (#662)
 
 - Fetch Kafka settings to client.
 
 - add gnmi protocol to get-installed-nodes RPC
 
 - Swagger: add drop-down for topology-id parameter
 
## :wrench: Other 
 
 - PUT and DELETE operations for callbacks
 
