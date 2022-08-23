# Uniconfig 5.0.11 Release Notes

## :white_check_mark: New Features

- Remove namespace from response (#77)

## :x: Bug Fixes

- uc shell: update simple value and list value simultaneously

- uc shell: transaction log ordering

- VHD-162 Fixed Issue with With-Defaults param. (#68)

- Serialization of int64, uint64, decimal types as string type

- Changed order of executing remove and add vlans for saos6 (#75)

- Fixed NETCONF reconnection attempts after connection timeout

- Removed parent-node-id from NETCONF layer

- Fixed synchronization of NETCONF session timeout

## :bulb: Improvements

- Fixed ordering of data inside transactions for SONiC device

- Implementation of common commands of relay agent for saos8 (#78)

- Implementation of common commands of relay agent for saos6 (#70)

- UC shell: autocompletion of nodes (#36)

- Fix parallelism in apply-template RPC (#73)

- Implementation of relay-agent sub-port command for saos8 (#47)

- Changed default value of content query parameter to 'config'

- Add sshd package to logback.xml with INFO level (#67)
 
