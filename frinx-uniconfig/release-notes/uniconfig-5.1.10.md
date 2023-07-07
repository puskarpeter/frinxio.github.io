# Uniconfig 5.1.10 Release Notes 
 
## :x: Bug Fixes 
 
 - Get API returns 3 response for single request (#1396) - VHD-324

 - Fixed too long error output in NETCONF LOG message - UNIC-649

 - UNIC-1319 Issue with Netconf install WorkFlow - fix logs for testing workflows - UNIC-1319

 - Upgrade Template didn't load repository - UNIC-1334

 - Save yang repository in transaction - VHD-324

## :bulb: Improvements 
 
 - store netconf keys in db (#1380) - VHD-326

 - maven cleanup (#1379) - UNIC-1291

 - Removed unused code from sal-dom-spi and dependencies

 - Extract shell actions to use RestconfDOMActionService (#1346) - UNIC-1313

## :wrench: Other 
 
 - Parse and fill datastore with initial JSON file in MDSAL mode
 
## :hammer: Dependency Upgrades 
 
 - build(deps): bump guava.version from 32.0.1-jre to 32.1.1-jre (#1388)
 
 - build(deps): bump janino from 3.1.9 to 3.1.10 (#1389)
 
 - build(deps): bump grpc.version from 1.56.0 to 1.56.1 (#1390)
 
 - build(deps): bump metainf-services from 1.9 to 1.11 (#1375)
 
 - build(deps): bump spring.boot.version from 3.0.7 to 3.0.8
 
 - build(deps): bump maven-clean-plugin from 3.2.0 to 3.3.1
 
 - build(deps): bump swagger-core from 2.2.12 to 2.2.14
 
 - build(deps): bump spotbugs-maven-plugin from 4.7.3.4 to 4.7.3.5
 
 - build(deps): bump checkstyle from 10.12.0 to 10.12.1
 
 - build(deps): bump bouncycastle.version from 1.74 to 1.75
 
 - build(deps-dev): bump flyway-core from 9.19.4 to 9.20.0
 
 - build(deps): bump commons-codec from 1.15 to 1.16.0
 
 - build(deps): bump sshd.version from 2.9.2 to 2.10.0 (#1251)
 
 - build(deps): bump netty-handler in /commons/parents/odlparent
 
 - build(deps): bump docker/login-action from 2.1.0 to 2.2.0
 
 - build(deps): bump actions/setup-python from 4.5.0 to 4.6.1
 
 - build(deps): bump json from 20230227 to 20230618
 
 - build(deps): bump spring-jdbc from 6.0.9 to 6.0.10
 
 - build(deps): bump bouncycastle.version from 1.73 to 1.74
 
 - build(deps): bump mockito.core.version from 5.3.1 to 5.4.0
 
 - build(deps): bump truth.version from 1.1.4 to 1.1.5
 
 - build(deps): bump maven-invoker-plugin from 3.5.1 to 3.6.0
 
 - build(deps): bump maven-shade-plugin from 3.4.1 to 3.5.0
 
