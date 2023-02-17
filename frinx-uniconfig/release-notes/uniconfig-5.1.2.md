# Uniconfig 5.1.2 Release Notes 
 
## :white_check_mark: New Features 
 
 - Implementation of RPD TUs for CER(Arris)
 
 - Implementation of Cable-Mac Oper TUs for CER(Arris)
 
 - Replace paths feature
 
 - Implementation of cable-upstream TUs for CER(Arris)
 
## :x: Bug Fixes 
 
 - Added new control to check if cached prompt is invalid (#812)
 
 - Fixed writer of cable upstream interface
 
 - Fix delete request in replace-paths
 
 - Fixed schema context building
 
 - Changed log level in mockito-configuration to INFO
 
 - Fix wrong groupIds

 - Java based migration for huawei config
 
 - Bulk-edit - removed the version comparison before version drop procedure
 
 - Bump dependencycheck.version, update suppress for CVE-2022-41915, CVE-2022-41881
 
## :bulb: Improvements 
 
 - Swagger: regular expressions with example values
 
 - Replace com.google.common.base.Optional with java.util.Optional
 
 - Update README.md running uniconfig from IDE
 
 - Add Dependency Upgrades to release notes
 
 - Unify antlr4 version
 
 - Bump dependency-check, cleanup unused suppressions
 
 - Adopt Mockito 5
 
 - Enable dependabot updates
 
 - Updated list of supported Unicode blocks (RegexUtils)
 
 - README - Update Running from IDE section
 
 - Extended TreeConfigParser to handle arris device's behavior for cable-upstreams
 
 - Migrate codebase to Java 17 & bump dependencies & clean maven structure
 
 - Added calc-diff result to audit logs
 
 - Change isInstalled method implementation in uniconfig-client
 
 - Remove license token from README.md and run_uniconfig.sh script.
 
 - Remove license server
 
 - Added read option to bulk-edit RPC
 
 - Bump sshd to 2.9.2
 
 - Prefer 'latest' repository in latest repository update process
 
 - Change status code if transaction is not valid. (#699)
 
## :hammer: Dependency Upgrades 
 
 - Bump commons-lang3 from 3.7 to 3.12.0
 
 - Bump org.eclipse.jdt.annotation from 2.1.0 to 2.2.700
 
 - Bump commons-dbcp2 from 2.7.0 to 2.9.0
 
 - Bump maven-enforcer-plugin from 3.1.0 to 3.2.1
 
 - Bump embedded-postgres from 1.2.10 to 2.0.3
 
 - Bump objenesis from 2.1 to 3.3
 
 - Bump properties-maven-plugin from 1.0.0 to 1.1.0
 
 - Bump netty.version from 4.1.86.Final to 4.1.89.Final
 
 - Bump byte-buddy.version from 1.12.22 to 1.13.0
 
 - Bump okhttp.version from 4.9.1 to 4.10.0
 
 - Bump disruptor from 3.3.10 to 3.4.4
 
 - Bump jackson-bom from 2.14.1 to 2.14.2
 
 - Bump jna.version from 4.5.0 to 5.13.0
 
 - Bump perfmark-api from 0.25.0 to 0.26.0
 
 - Bump grpc.version from 1.51.1 to 1.53.0
 
 - Bump antlr4-maven-plugin from 4.10.1 to 4.11.1
 
 - Bump httpclient from 4.5.13 to 4.5.14
 
