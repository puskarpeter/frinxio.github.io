# Uniconfig 5.1.6 Release Notes 
 
## :x: Bug Fixes 
 
 - Saos 8 command order fix.
 
 - Fixed execution order of commands for sub-port creation
 
 - Fixed a bug that causes cli closed error if config output and prompt has same length
 
 - Fix dryrun mount node task.
 
 - diff improvements (#1107)
 
 - Swagger: fix union type with patterns
 
 - Disable NETCONF level keepalive mechanism in streaming session
 
 - Fixed onEmpty section in templates for rpd ds and us conns for Arris Commscope
 
 - Fixed a bug that causes cli closed error for saos devices when commit or execute RPCs are triggered
 
## :bulb: Improvements 
 
 - Refactoring ServiceInstanceWriter
 
 - Adjusted log levels of common logs
 
 - Swagger: filterPath improvement
 
 - diff improvements (#1107)
 
 - Rewrite kafka configs (#1105)
 
## :wrench: Other 
 
 - JSON input in Uniconfig shell problem fix
 
 - Shell logger
 
 - Create and publish Netconf test tool image to DockerHub
 
## :hammer: Dependency Upgrades 
 
 - build(deps): bump jline.version from 3.22.0 to 3.23.0 (#998)
 
 - build(deps): bump bouncycastle.version from 1.72 to 1.73 (#1138)
 
 - build(deps-dev): bump flyway-core from 9.16.1 to 9.16.3 (#1139)
 
 - build(deps): bump actions/upload-artifact from 3.1.1 to 3.1.2 (#1131)
 
 - build(deps): bump opentelemetry-api from 1.24.0 to 1.25.0 (#1135)
 
 - build(deps): bump grpc.version from 1.54.0 to 1.54.1 (#1134)
 
 - build(deps): bump json-path from 2.7.0 to 2.8.0 (#1093)
 
 - build(deps): bump spotbugs-maven-plugin from 4.7.3.3 to 4.7.3.4 (#1126)
 
 - build(deps): bump jetty-bom from 11.0.14 to 11.0.15 (#1127)
 
 - build(deps): bump protobuf.version from 3.22.2 to 3.22.3
 
 - build(deps): bump byte-buddy.version from 1.14.3 to 1.14.4
 
 - build(deps): bump triemap from 1.2.0 to 1.3.0
 
 - build(deps): bump netty.version from 4.1.90.Final to 4.1.91.Final (#1113)
 
 - build(deps): bump maven-enforcer-plugin from 3.2.1 to 3.3.0 (#1114)
 
 - build(deps): bump maven-invoker-plugin from 3.5.0 to 3.5.1 (#1115)
 
 - build(deps): bump maven-resources-plugin from 3.3.0 to 3.3.1
 
 - build(deps): bump byte-buddy.version from 1.14.2 to 1.14.3
 
 - build(deps): bump kotlin.version from 1.8.10 to 1.8.20
 
