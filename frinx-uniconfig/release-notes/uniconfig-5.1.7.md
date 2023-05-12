# Uniconfig 5.1.7 Release Notes 
 
## :white_check_mark: New Features 
 
 - Lazy loading/unloading of native schema contexts (#1171)
 
 - Creation of MIB context to SchemaContext adapter (#1169)
 
## :x: Bug Fixes 
 
 - Fixed lazy apply-template
 
 - Fixed a bug that causes cli closed error if config output's length is less than prompt's length after config output is trimmed
 
 - Fix Swagger regex example generation
 
 - Fixed loading of schema context from swagger directory
 
 - Make request max size configurable for gnmi devices
 
 - Integrate encryption in create-multiple-templates RPC.
 
 - Fixed UniconfigTransactionsMediator initialization (#1181)
 
 - Remove TestNG (#1159)
 
 - Fix UC stuck when CPU is full and queue is empty (#1168)
 
## :bulb: Improvements 
 
 - Support for gnmi in shell
 
 - Implementation of idle timeout print in CLI (#1172)
 
 - Lazy loading/unloading of native schema contexts (#1171)
 
 - Improved the processing time of sync RPC for ios/iosxe devices
 
 - Unify movement in shell (#1005)
 
 - Enabled cable-upstream writer for interfaces that has number/number/number pattern as name
 
 - Improved apply-template RPC (#1111)
 
## :wrench: Other 
 
 - Add lazy loading to shell
 
## :hammer: Dependency Upgrades 
 
 - build(deps): bump protobuf.version from 3.22.3 to 3.22.4
 
 - build(deps): bump jgrapht.version from 1.5.1 to 1.5.2
 
 - build(deps): bump jakarta.activation-api from 2.1.1 to 2.1.2 (#1178)
 
 - build(deps): bump netty.version from 4.1.91.Final to 4.1.92.Final (#1173)
 
 - build(deps): bump kotlin.version from 1.8.20 to 1.8.21 (#1174)
 
 - build(deps): bump junit.jupiter.version from 5.9.2 to 5.9.3 (#1175)
 
 - build(deps): bump checkstyle from 10.9.3 to 10.10.0 (#1176)
 
 - build(deps-dev): bump flyway-core from 9.16.3 to 9.17.0 (#1177)
 
 - build(deps): bump mockito.core.version from 5.2.0 to 5.3.1 (#1156)
 
 - build(deps): bump maven-checkstyle-plugin from 3.2.1 to 3.2.2 (#1157)
 
 - build(deps): bump okhttp.version from 4.10.0 to 4.11.0 (#1155)
 
 - build(deps): bump jackson-bom from 2.14.2 to 2.15.0 (#1158)
 
 - build(deps-dev): bump maven-plugin-annotations from 3.8.1 to 3.8.2 (#1152)
 
 - build(deps): bump maven-project-info-reports-plugin from 3.4.2 to 3.4.3 (#1145)
 
 - build(deps): bump maven-plugin-plugin from 3.8.1 to 3.8.2 (#1154)
 
 - build(deps): bump jackson-databind from 2.14.2 to 2.15.0 (#1153)
 
