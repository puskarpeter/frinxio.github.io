# Uniconfig 5.0.14 Release Notes 
 
## :white_check_mark: New Features 
 
 - Added a flag to disable confirmed-commit phase in commit RPC (#181)
 
## :x: Bug Fixes 
 
 - Fix parsing of sslPassword parameter
 
 - Fix setting of DbConnectionConfig parameters
 
 - Fix of incorrect UC behavior when on limit with DB connections
 
 - Fixed recovery of Cipher object
 
 - Adding 'rsa_' prefix to encrypted data
 
 - Fixed parsing NETCONF action response
 
 - Fixed creation of aug with admin-state leaf
 
 - Updated config metadata pattern in reader for ios xe devices (#174)
 
 - Fixed encryption (#170)
 
 - Disable html escaping in callbacks output
 
 - Fixed SAOS Qos TU writer
 
 - Make tailf:info revision independent
 
 - Jsonb-filter multiple schemas bugfix
 
 - Fix Flyway when using SSL encryption
 
 - Changed the way to get config metadata for ios xe devices
 
 - Fixed duplicate module lookup in path deserializer (RESTCONF) (#150)
 
 - Fixed detection and recovery from cyclic dependency error in YANGs (#161)
 
 - Fix adding release notes to documentation repository
 
## :bulb: Improvements 
 
 - Internal delete for trunk-vlans
 
 - JSONB-filter improvement
 
