# Uniconfig 5.1.4 Release Notes 
 
## :white_check_mark: New Features 
 
 - Implementation of MIB repository & context
 
 - Implemented RPD related commands to fiber-node TU for Arris Commscope
 
## :x: Bug Fixes 
 
 - Fixed RPD related writers for Arris Commscope
 
 - Fixed update templates in CableInterfaceUpstreamConfigWriter for Arris Commscope
 
 - Fix calc-diff when data is in LeafNode
 
 - Fix subtree calc-diff in audit log when data has not changed
 
 - Fixed callback leaf-list input parameter (#949)
 
 - Added a verification to check if lineIndex is lower than total number of parsed lines for multiline commands
 
 - Fixed CLI SSH KEX initialization
 
 - Fixed data decryption during apply-template RPC
 
## :bulb: Improvements 
 
 - Swagger: shorter operational path
 
## :hammer: Dependency Upgrades 
 
 - build(deps): bump dokka-maven-plugin from 1.7.20 to 1.8.10
 
 - build(deps-dev): bump maven-plugin-annotations from 3.7.1 to 3.8.1
 
 - build(deps): bump json from 20220924 to 20230227
 
 - build(deps): bump dependency-check-maven from 8.1.0 to 8.1.2
 
 - Bump reflections from 0.9.11 to 0.10.2
 
 - Bump maven-compiler-plugin from 3.10.1 to 3.11.0
 
 - Bump jetty-bom from 11.0.13 to 11.0.14
 
 - Bump maven-plugin-plugin from 3.7.1 to 3.8.1
 
 - Bump metrics-core from 4.2.16 to 4.2.17
 
 - Bump spotbugs-maven-plugin from 4.7.3.0 to 4.7.3.2
 
 - Bump maven-dependency-plugin from 3.1.1 to 3.5.0
 
 - Bump checkstyle from 10.7.0 to 10.8.0
 
 - Bump maven-antrun-plugin from 1.8 to 3.1.0
 
