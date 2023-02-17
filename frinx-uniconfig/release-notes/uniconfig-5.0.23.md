# Uniconfig 5.0.23 Release Notes 
 
## :white_check_mark: New Features 
 
 - Implementation of RPD TUs for CER(Arris)
 
 - Implementation of Cable-Mac Oper TUs for CER(Arris)
 
 - Replace paths feature
 
 - Implementation of cable-upstream TUs for CER(Arris)
 
## :x: Bug Fixes 
 
 - Added new control to check if cached prompt is invalid (#809)
 
 - Fixed writer of cable upstream interface
 
 - Added new control to check if cached prompt is invalid (#633)
 
 - Fix delete request in replace-paths
 
 - Fixed schema context building

 - Java based migration for huawei config

 - Bulk-edit - removed the version comparison before version drop procedure
 
 - Bump dependencycheck.version, update suppress for CVE-2022-41915, CVE-2022-41881
 
## :bulb: Improvements 
 
 - Swagger: regular expressions with example values
 
 - Extended TreeConfigParser to handle arris device's behavior for cable-upstreams
 
 - Change isInstalled method implementation in uniconfig-client
 
 - JRE-17 compatibility
 
 - Added read option to bulk-edit RPC
 
 - Bump sshd to 2.9.2
 
 - Prefer 'latest' repository in latest repository update process
 
 - Change status code if transaction is not valid. (#711)
 
