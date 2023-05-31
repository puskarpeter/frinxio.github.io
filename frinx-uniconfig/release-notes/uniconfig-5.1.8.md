# Uniconfig 5.1.8 Release Notes 
 
## :white_check_mark: New Features 
 
 - Add change-encryption-status rpc (#1259) - UNIC-1090

 - Added some commands for collecting slot data for IOS-XE - VZ-734

## :x: Bug Fixes 
 
 - Swagger: Fix path filtering ignoring cruds in lists - UNIC-1315

 - Fix failing shell tests (#1285)

 - Compare decrypted strings in calculate-diff procedure (#1266) - UNIC-1173

 - Changed execution order of commands for CPE ZTP provision for SAOS8

## :bulb: Improvements 
 
 - Improved error output when two transactions want to update same data … (#1238)

 - Swagger: Improve OpenAPI difference calculation - UNIC-1298

 - Provide option for reading mount-point info - UNIC-1097

 - Refactored InstanceIdentifierContext (#1249) - UNIC-1211

 - Add option to gnmi-topology to read specific data - PANT-72

 - Add unsuported keys for cli connection (#1203)

 - Add JIRA tag to release notes - UNIC-1243

 - Optimize LeafRef context build. - UNIC-988

 - Build LeafRef Tree in background. - UNIC-988

 - Separated reader/writer for IUCs from main classes for Arris Commscope

 - Unify annotation usage in uniconfig codebase

 - support error info (#1201) - UNIC-1136

 - Rewrite RestConf module DI (#1202) - UNIC-1101

## :wrench: Other 
 
 - Create a new set of installation parameters
 
## :hammer: Dependency Upgrades 
 
 - build(deps): bump maven-plugin-plugin from 3.8.2 to 3.9.0
 
 - build(deps-dev): bump flyway-core from 9.17.0 to 9.19.1
 
 - build(deps): bump kotlinx-coroutines-core from 1.7.0 to 1.7.1
 
 - build(deps): bump checkstyle from 10.11.0 to 10.12.0
 
 - build(deps): bump triemap from 1.3.0 to 1.3.1
 
 - build(deps): bump embedded-postgres-binaries-linux-amd64 from 13.10.0 to 13.11.0 (#1274)
 
 - build(deps): bump embedded-postgres from 2.0.3 to 2.0.4 (#1270)
 
 - build(deps): bump jackson-databind from 2.15.0 to 2.15.1 (#1264)
 
 - build(deps): bump protobuf.version from 3.23.0 to 3.23.1 (#1273)
 
 - build(deps-dev): bump maven-plugin-annotations from 3.8.2 to 3.9.0 (#1265)
 
 - build(deps): bump maven-source-plugin from 3.2.1 to 3.3.0 (#1271)
 
 - build(deps): bump maven-assembly-plugin from 3.5.0 to 3.6.0 (#1272)
 
 - build(deps): bump spring.boot.version from 3.0.6 to 3.0.7 (#1269)
 
 - build(deps): bump netty.version from 4.1.92.Final to 4.1.93.Final
 
 - build(deps): bump git-commit-id-maven-plugin from 5.0.0 to 6.0.0
 
 - build(deps): bump spring-jdbc from 6.0.8 to 6.0.9
 
 - build(deps): bump antlr4.version from 4.12.0 to 4.13.0 (#1256)
 
 - build(deps): bump checkstyle from 10.10.0 to 10.11.0 (#1254)
 
 - build(deps): bump guice.version from 5.1.0 to 7.0.0 (#1253)
 
 - build(deps): bump jackson-bom from 2.15.0 to 2.15.1
 
 - build(deps-dev): bump swagger-parser from 1.0.65 to 1.0.66
 
 - build(deps): bump swagger-core from 2.2.9 to 2.2.10
 
 - build(deps): bump jersey.version from 3.1.1 to 3.1.2
 
 - build(deps): bump maven-checkstyle-plugin from 3.2.2 to 3.3.0
 
 - build(deps): bump maven.core.version from 3.9.1 to 3.9.2 (#1215)
 
 - build(deps): bump maven-remote-resources-plugin from 3.0.0 to 3.1.0
 
 - build(deps): bump build-helper-maven-plugin from 3.3.0 to 3.4.0
 
 - build(deps): bump json-smart from 2.4.10 to 2.4.11
 
 - build(deps): bump protobuf.version from 3.22.4 to 3.23.0
 
 - build(deps): bump sshd.version from 2.9.2 to 2.10.0
 
 - build(deps): bump opentelemetry-api from 1.25.0 to 1.26.0 (#1195)
 
 - build(deps): bump maven-failsafe-plugin from 3.0.0 to 3.1.0 (#1196)
 
 - build(deps): bump maven-surefire-plugin from 3.0.0 to 3.1.0 (#1197)
 
 - build(deps): bump kotlinx-coroutines-core from 1.6.4 to 1.7.0 (#1198)
 
 - build(deps): bump grpc.version from 1.54.1 to 1.55.1 (#1199)
 
