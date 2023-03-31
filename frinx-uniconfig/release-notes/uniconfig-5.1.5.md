# Uniconfig 5.1.5 Release Notes 
 
## :white_check_mark: New Features 
 
 - Implement rate limiting (#1061)
 
 - Add DOMRpcService for gNOI
 
 - Subtree-based resolution of conflicts between committed nodes (#1008)
 
## :x: Bug Fixes 
 
 - Fix audit-log diff feature (#1056)
 
 - Fixed update template to update fiber node for Arris Commscope
 
 - Fix: Duplicate module name in Yang schemas
 
 - Fixed reading config until timeout (#1067)
 
 - Fixed uninstall node rpc
 
 - Fixed parsing leaf-list into JSONObject
 
 - Fixed construction of Tree (callbacks system test)
 
 - Fixed problem with re-write data of transaction by other transaction (#1031)
 
 - Fixed method to add unistore FP
 
 - Fix bug with audit log while calling commit RPC (#1007)
 
 - Fix deriving of DB reader path
 
 - Add missing sslpassword configuration parameter (#990)
 
 - fix read only lock in uniconfig task executor (#982)
 
 - Fixed overriding of default mount settings by uniconfig-client
 
## :bulb: Improvements 
 
 - Swagger: Migrate unit tests to v3
 
 - Added topology-id to DCE notification
 
 - cli-shell set callback... suggest only commands that contain input body
 
 - Setting default spin/park time in notification router config
 
 - Optimised sending of internal notifications
 
 - Optimised lookup in modified uniconfig-topology & network-topology modules
 
 - Optimise detection of updated mount data in notification monitoring system
 
 - Add additional logs to precondition checks in SchemaContextUtil
 
 - Subtree-based resolution of conflicts between committed nodes (#1008)
 
 - Improved the processing time of sync RPC for ios devices
 
 - Optimisation of single transaction-log entry reading
 
 - Added dedicated reader for single transaction-log entry
 
 - Add batching process for parallel reading of config
 
## :wrench: Other 
 
 - Arris CER interface bugfix (#1086)
 
 - Optimalization of handling saos devices
 
## :hammer: Dependency Upgrades 
 
 - build(deps-dev): bump swagger-parser from 1.0.64 to 1.0.65 (#1074)
 
 - build(deps): bump maven-deploy-plugin from 3.1.0 to 3.1.1 (#1072)
 
 - build(deps): bump maven-install-plugin from 3.1.0 to 3.1.1 (#1075)
 
 - build(deps): bump checkstyle from 10.9.2 to 10.9.3 (#1073)
 
 - build(deps): bump grpc.version from 1.53.0 to 1.54.0 (#1071)
 
 - build(deps): bump spring-jdbc from 5.3.25 to 5.3.26 (#1036)
 
 - build(deps): bump spotbugs-maven-plugin from 4.7.3.2 to 4.7.3.3 (#1070)
 
 - build(deps): bump spring.boot.version from 2.7.9 to 2.7.10 (#1069)
 
 - build(deps): bump commons-compress from 1.22 to 1.23.0 (#1059)
 
 - build(deps): bump dependency-check-maven from 8.1.2 to 8.2.1 (#1062)
 
 - build(deps-dev): bump flyway-core from 9.16.0 to 9.16.1 (#1052)
 
 - build(deps): bump maven-release-plugin from 3.0.0-M7 to 3.0.0 (#1037)
 
 - build(deps): bump metrics-core from 4.2.17 to 4.2.18 (#1038)
 
 - build(deps): bump swagger-core from 2.2.8 to 2.2.9 (#1039)
 
 - build(deps): bump maven.core.version from 3.9.0 to 3.9.1 (#1027)
 
 - build(deps): bump checkstyle from 10.8.1 to 10.9.2 (#1028)
 
 - build(deps): bump maven-help-plugin from 3.3.0 to 3.4.0 (#1025)
 
 - build(deps): bump postgresql from 42.5.4 to 42.6.0 (#1026)
 
 - build(deps-dev): bump flyway-core from 9.15.2 to 9.16.0 (#1012)
 
 - build(deps): bump maven.surefire.version from 3.0.0-M9 to 3.0.0 (#1013)
 
 - build(deps): bump maven-failsafe-plugin from 3.0.0-M9 to 3.0.0 (#1011)
 
 - build(deps): bump netty.version from 4.1.89.Final to 4.1.90.Final (#1010)
 
 - build(deps): bump opentelemetry-api from 1.23.1 to 1.24.0 (#999)
 
 - build(deps): bump protobuf.version from 3.22.1 to 3.22.2 (#1000)
 
 - build(deps): bump byte-buddy.version from 1.14.1 to 1.14.2 (#1003)
 
 - build(deps): bump mockito-core from 5.1.1 to 5.2.0 (#987)
 
 - build(deps): bump checkstyle from 10.8.0 to 10.8.1 (#988)
 
 - build(deps): bump protobuf.version from 3.22.0 to 3.22.1
 
 - build(deps): bump jline.version from 3.22.0 to 3.23.0
 
 - build(deps): bump byte-buddy.version from 1.14.0 to 1.14.1
 
 - build(deps-dev): bump flyway-core from 9.15.1 to 9.15.2
 
