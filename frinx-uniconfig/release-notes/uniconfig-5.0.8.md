# Uniconfig 5.0.8 Release Notes

## :white_check_mark: New Features

- Created TU for Arris(CER) device

- Install-node without mounting/syncing configuration from device

- Option to divide OpenAPI files into modules

## :x: Bug Fixes

- Uniconfig-client: increased default HTTP response read timeout

- Fixed NETCONF connection timeout

- Fixed number of NETCONF reconnection attempts

- Fixed waiting for NETCONF dry-run mountpoint

- Fixed reading of default NETCONF parameters

- Added 'get-template-info' RPC to oper mode (shell)

- Huawei install DB parsing issue

- Fixed memory visibility issues in MountpointRegistry

- Fixed parsing junos xml configuration

- Fixed parsing xml configuration with reordered lists items

- Fixed list of available RPCs in UniConfig Shell

## :bulb: Improvements

- Optimization of calc-diff RPC after replace-config-with-oper RPC

- Install-node without mounting/syncing configuration from device improvements

- Added missing attributes to SAOS6 Interface

- Remove OSS index checks from owasp

- Generate release notes during merge job
 
