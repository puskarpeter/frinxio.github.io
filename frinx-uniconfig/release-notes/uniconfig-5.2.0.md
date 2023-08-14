# Uniconfig 5.2.0 Release Notes 
 
## :white_check_mark: New Features 
 
 - Parse NOTIFICATION-TYPE from MIB schemas. (#1545) - UNIC-1382

 - Add rpc change-encryption-keys (#1441) - UNIC-1239

 - support for gnmi-notifications - Notification + Subscription service (#1109) - UNIC-1184

 - UNIC-1308

 - SNMP topology (#1438) - UNIC-1202

 - UNIC-1202

 - UNIC-1202

 - UNIC-1202

 - UNIC-1202

## :x: Bug Fixes 
 
 - fix_regex_matching_of_identity - UNIC-1375

 - Fixed generation of commit diff notifications

 - Fix identityRef parsing (#1502) - UNIC-1356

 - Swagger: Fix generation of operational data from Uniconfig schemas - UNIC-1280

 - Fixed unmounting of node that is in connecting state - UNIC-1281

## :bulb: Improvements 
 
 - Cleanup dependencies in uniconfig module (#1542) - UNIC-1381

 - Add gnmi subscription parameters (#1505) - UNIC-1369

 - UNIC-1369

 - Merged mdsal-dom-api into sal-dom-api module (#1543)

 - fix connection manager (#1532)

 - Constants refactoring (#1511) - UNIC-1257

 - Caching of calculate-diff response in transaction

 -  Shell explicit show in config state (#1484) - UNIC-1325

 - Shell caching data (#1480) - UNIC-1357

 - SNMP refactoring of snmp-topology (#1472) - UNIC-1343

 - Prevented sending command for rpd-index, ucam and dcam attributes if there is no change for CER rpd interfaces

 - Changing use case of prompt stylization - UNIC-977

 - Enabling and cleaning up SHELL checkstyles (#1451) - UNIC-1345

 - Unifying, renaming and increasing readability of UC-shell - UNIC-977

 - Add mutable transaction to Shell (#1399) - UNIC-1312

 - Swagger: Unit tests - UNIC-1186

 - Removed sal-common-impl module (#1426)

 - Merged mdsal-dom-spi to sal-dom-spi module (#1415)

 - add ValueCase to gnmi codec - UNIC-1113

## :computer: API 
 
 - Refactor connection-manager RPCs (#1423) - UNIC-1283

## :wrench: Other 
 
 - Read All data type on specific paths
 
## :hammer: Dependency Upgrades 
 
 - build(deps): bump com.puppycrawl.tools:checkstyle from 10.12.1 to 10.12.2 (#1561)
 
 - build(deps): bump ch.qos.logback:logback-classic from 1.4.8 to 1.4.9 (#1562)
 
 - build(deps): bump jmh-core.version from 1.36 to 1.37 (#1558)
 
 - build(deps): bump grpc.version from 1.57.0 to 1.57.1 (#1559)
 
 - build(deps): bump com.google.guava:guava from 32.1.1-jre to 32.1.2-jre (#1557)
 
 - build(deps): bump maven.core.version from 3.9.3 to 3.9.4 (#1560)
 
 - build(deps): bump org.codehaus.mojo:properties-maven-plugin from 1.1.0 to 1.2.0 (#1522)
 
 - build(deps-dev): bump org.apache.commons:commons-lang3 from 3.12.0 to 3.13.0 (#1523)
 
 - build(deps): bump bouncycastle.version from 1.75 to 1.76 (#1521)
 
 - build(deps-dev): bump org.flywaydb:flyway-core from 9.21.0 to 9.21.1 (#1520)
 
 - build(deps): bump org.jetbrains.kotlinx:kotlinx-coroutines-core from 1.7.2 to 1.7.3 (#1519)
 
 - build(deps): bump jersey.version from 3.1.2 to 3.1.3 (#1518)
 
 - build(deps): bump grpc.version from 1.56.1 to 1.57.0 (#1517)
 
 - build(deps): bump netty.version from 4.1.95.Final to 4.1.96.Final (#1516)
 
 - build(deps): bump ch.qos.logback:logback-classic from 1.4.6 to 1.4.8 (#1483)
 
 - build(deps): bump org.junit.jupiter:junit-jupiter from 5.9.3 to 5.10.0 (#1479)
 
 - build(deps): bump org.apache.kafka:kafka-clients from 3.5.0 to 3.5.1 (#1476)
 
 - build(deps): bump org.xmlunit:xmlunit-legacy from 2.6.1 to 2.9.1 (#1478)
 
 - build(deps): bump spring-jdbc from 6.0.10 to 6.0.11 (#1434)
 
 - build(deps): bump spring.boot.version from 3.1.1 to 3.1.2 (#1475)
 
 - build(deps-dev): bump org.flywaydb:flyway-core from 9.20.0 to 9.21.0 (#1474)
 
 - build(deps): bump netty.version from 4.1.94.Final to 4.1.95.Final (#1477)
 
 - build(deps): bump maven.core.version from 3.9.2 to 3.9.3 (#1358)
 
 - build(deps): bump kotlinx-coroutines-core from 1.7.1 to 1.7.2 (#1392)
 
 - build(deps): bump kotlin.version from 1.8.22 to 1.9.0 (#1391)
 
 - build(deps): bump protobuf.version from 3.23.2 to 3.23.4 (#1395)
 
 - build(deps): bump swagger-core from 2.2.14 to 2.2.15 (#1405)
 
 - build(deps): bump json-smart from 2.4.11 to 2.5.0 (#1404)
 
 - build(deps): bump opentelemetry-api from 1.27.0 to 1.28.0 (#1406)
 
