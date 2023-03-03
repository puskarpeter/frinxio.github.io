# Uniconfig 5.0.24 Release Notes 
 
## :white_check_mark: New Features 
 
 - Implemented RPD related commands to fiber-node TU for Arris Commscope
 
 - Swagger: difference between OpenAPI specifications
 
## :x: Bug Fixes 
 
 - Fixed RPD related writers for Arris Commscope
 
 - Fixed update templates in CableInterfaceUpstreamConfigWriter for Arris Commscope
 
 - Fixed callback leaf-list input parameter (#948)
 
 - Added a verification to check if lineIndex is lower than total number of parsed lines for multiline commands
 
 - Fixed CLI SSH KEX initialization
 
 - Fixed data decryption during apply-template RPC
 
 - Fixed regex for "show cable modem" command (#897)
 
 - Generate action names in java constants
 
## :bulb: Improvements 
 
 - Swagger: shorter operational path
 
## :wrench: Other 
 
 - Implementation of RPD TUs for CER(Arris) (#819)
 
