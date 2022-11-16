# Uniconfig 5.0.18 Release Notes 
 
## :white_check_mark: New Features 
 
 - Implemented TU for collecting all the information in NTP MCS for Saos6 and Saos8 (#420)
 
 - Implemented low priority fields for collecting inventory for SAOS6 CEN(ring) (#341)
 
## :x: Bug Fixes 
 
 - Swagger: Fix generation of arguments in path
 
 - Fixed cleanup of existing MP during mount-node RPC
 
 - Swagger: fix generation of choice nodes
 
 - Fixed encryption of sensitive info passed via template variables (#326)
 
 - fix Jsonb filter element filtering
 
 - Swagger - Fix request generation
 
 - Fixed passing leaf-list in shell callbacks
 
## :bulb: Improvements 
 
 - Fix Logback and cleanup POMs
 
 - Swagger: Custom operational path
 
 - Improved reporting of parsing issues in RESTCONF
 
 - Swagger - Improve start file
 
 - Changed order of some commands for SAOS8 (#348)
 
 - Swagger: generate augmentations in respective modules
 
 - Expose request-timeout parameter
 
 - Bump dependency-check to 7.3.0
 
 - readEntireConfig toString returns plain content
 
 - Reading mount configuration in the uniconfig-client
 
 - Swagger: generate augmentations in respective modules
 
