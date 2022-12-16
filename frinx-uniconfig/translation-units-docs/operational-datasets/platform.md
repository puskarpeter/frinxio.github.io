# Platform

## URL

```
frinx-openconfig-platform:components
```

## OPENCONFIG YANG

[YANG models](https://github.com/FRINXio/openconfig/tree/master/platform/src/main/yang)

```javascript
{
    "components": {
        "component": [
            {
                "name": "<component_key>",
                "state": {
                    "name": "<component_name>",
                    "id": "<component_id>",
                    "description": "<component_description>",
                    "version": "<version_id>",
                    "software-version": "<software_version>",
                    "frinx-cisco-platform-extension:sn": "<component_sn>",
                    "frinx-cisco-platform-extension:pid": "<component_pid>",
                    "frinx-cisco-platform-extension:vid": "<component_vid>",
                    "frinx-ciena-platform-extension:power-sn": "<power_sn>",
                    "frinx-ciena-platform-extension:power-part-number": "<power_pn>",
                    "frinx-ciena-platform-extension:power-revision": "<power_rev>",
                    "frinx-ciena-platform-extension:vendor-pid-part-number": "<vendor_name>",
                    "frinx-ciena-platfrom-extension:vendor-sn": "<port_vendor_sn>",
                    "frinx-ciena-platform-extension:vendor-port-number": "<port_vendor_pn>",
                    "frinx-ciena-platform-extension:vendor-revision": "<port_vendor_rev>",
                    "frinx-ciena-platform-extension:platform-description": "<platform_description>",
                    "frinx-ciena-platform-extension:platform-name": "<platform_name>",
                    "frinx-ciena-platform-extension:device-sn": "<device_sn>",
                    "frinx-ciena-platform-extension:software-running-package": "<running_package>",
                    "frinx-ciena-platform-extension:device-param-version": "<param_version>",
                    "frinx-ciena-platform-extension:ethernet-base-address": "<eth_base_address>",
                    "frinx-ciena-platform-extension:ethernet-address-block-size": "<eth_addr_block_size>",
                    "frinx-ciena-platform-extension:module-sn": "<module_sn>",
                    "frinx-ciena-platform-extension:model-part-number": "<model_pn>",
                    "frinx-ciena-platform-extension:model-revision": "<model_rev>",
                    "frinx-ciena-platform-extension:product-id": "<product_id>",
                    "frinx-ciena-platform-extension:manufactured-date": "<manufactured_date>",
                    "frinx-ciena-platform-extension:clei-code": "<clei_code>",
                    "frinx-ciena-platform-extension:bar-code": "<bar_code>",
                    "frinx-ciena-platform-extension:backplane-assy-sn": "<backplane_assy_sn>",
                    "frinx-ciena-platform-extension:backplane-assy-pn": "<backplane_assy_pn>",
                    "frinx-ciena-platform-extension:backplane-assy-rev": "<backplane_assy_rev>",
                    "frinx-ciena-platform-extension:backplane-sn": "<backplane_sn>",
                    "frinx-ciena-platform-extension:backplane-pn": "<backplane_pn>",
                    "frinx-ciena-platform-extension:backplane-rev": "<backplane_rev>",
                    "frinx-ciena-platform-extension:software-compatibility": "<software_compatibility>",
                    "frinx-ciena-platform-extension:functional-test-count": "<functional_test_count>",
                    "frinx-ciena-platform-extension:board-sn": "<board_sn>",
                    "frinx-ciena-platform-extension:board-pn": "<board_pn>",
                    "frinx-ciena-platform-extension:board-rev": "<board_rev>",
                    "frinx-ciena-platform-extension:fault-card": "<fault_card>",
                    "frinx-ciena-platform-extension:main-board": {
                        "module-sn": "<main_module_sn>",
                        "model-part-number": "<main_model_pn>",
                        "model-revision": "<main_model_rev>",
                        "board-sn": "<main_board_sn>",
                        "board-pn": "<main_board_pn>",
                        "board-rev": "<main_board_rev>",
                        "manufactured-date": "<main_manufactured_date>"
                    },
                    "frinx-ciena-platform-extension:cpu-board": {
                        "ethernet-base-address": "<cpu_eth_base_addr>",
                        "ethernet-address-block-size": "<cpu_eth_addr_block>",
                        "module-sn": "<cpu_module_sn>",
                        "model-part-number": "<cpu_model_pn>",
                        "model-revision": "<cpu_model_rev>",
                        "product-id": "<cpu_product_id>",
                        "manufactured-date": "<cpu_maunfactured_date>",
                        "clei-code": "<cpu_clei_code>",
                        "bar-code": "<cpu_bar_code>",
                        "board-sn": "<cpu_board_sn>",
                        "board-pn": "<cpu_board_pn>",
                        "board-rev": "<cpu_board_rev>",
                        "software-compatibility": "<cpu_soft_comp>",
                        "functional-test-count": "<cpu_func_test_cnt>",
                        "fault-card": "<cpu_fault_card>"
                    },
                    "frinx-arris-platform-extension:transceiver": {
                        "serial-number": "<transceiver_serial_number>",
                        "temperature": "<transceiver_temperature>",
                        "vendor": "<transceiver_vendor>",
                        "revision": "<transceiver_revision>",
                        "date-code": "<transceiver_date_code>",
                        "ch-0-tx-bias": "<transceiver_ch_0_tx_bias>",
                        "t-type": "<transceiver_t_type>",
                        "voltage": "<transceiver_voltage>",
                        "speed": "<transceiver_speed>",
                        "part-number": "<transceiver_part_number>",
                        "type": "<transceiver_type>",
                        "ch-0-tx-power": "<transceiver_ch0_tx_power>",
                        "ch-0-rx-power": "<transceiver_ch0_rx_power>"
                    },
                    "frinx-arris-platform-extension:chassis": {
                        "model-version": "<chassis_model_version>",
                        "serial-number": "<chassis_serial_number>",
                        "model-name": "<chassis_model_name>"
                    },
                    "frinx-arris-platform-extension:version-detail": {
                        "serial-number": "<version_serial_number>",
                        "cpu-speed": "<version_cpu_speed>",
                        "active-sw": "<version_active_sw>",
                        "active-patch": "<version_active_patch>",
                        "pic-serial-number": "<version_pic_serial_number>",
                        "ram-size": "<version_ram_size>",
                        "model-name": "<version_model_name>",
                        "nor-flash-size": "<version_nor_flash_size>",
                        "nand-flash-size": "<version_nand_flash_size>",
                        "model-version": "<version_model_version>",
                        "reason-last-booted": "<version_reason_last_booted>",
                        "firmware-version": "<version_firmware_version>",
                        "bus-speed": "<version_bus_speed>",
                        "uptime": "<version_uptime>",
                        "type": "<version_type>",
                        "pic-model-name": "<version_pic_model_name>",
                        "pic-model-version": "<version_pic_model_version>"
                    }
                },
                "config": {
                    "name": "<component_key>"
                }
            },
            {
                "name": "OS",
                "state": {
                    "name": "OS",
                    "frinx-arris-platform-extension:license": {
                        "system-lld-us-asf": <license_lld_us_asf>,    // true or false
                        "chassis-serial-number": "<license_chassis_serial_number>",
                        "system-legal-intercept": <license_system_legal_intercept>,    //true or false
                        "system-calea": <license_system_calea>,    // true or false
                        "system-laes": <license_system_laes>,    // true or false
                        "system-us-pgs": <license_system_us_pgs>,    // true or false
                        "system-principal-core": <license_system_principal_core>,    // true or false
                        "system-auxiliary-core": <license_system_aux_core>    // true or false
                    },
                    "frinx-arris-platform-extension:lldp": {
                        "lldp-status": "<lldp_status>",
                        "lldp-ad-interval": "<lldp_ad_interval>",
                        "lldp-ad-hold-time": "<lldp_ad_hold_time>"
                    },
                    "frinx-arris-platform-extension:version-detail": {
                        "last-booted-time": "<version_last_booted_time>"
                    },
                    "frinx-arris-platform-extension:chassis": {
                        "chassis-type": "<chassis_type>",
                        "model-version": "<chassis_model_version_type>",
                        "serial-number": "<chassis_serial_number_type>",
                        "model-name": "<chassis_model_name_type>"
                    }
                },
                "config": {
                    "name": "OS"
                }
            }
        ]
    }
}
```

## OS Configuration Commands

### Cisco IOS Classic

#### CLI

---
<pre>
IOS#show inventory
NAME: "&lt;component_name&gt;", DESCR: "&lt;component_description&gt;"
PID: &lt;component_pid&gt;  , VID: &lt;component_vid&gt;  , SN: &lt;component_sn&gt;

IOS#show version
Cisco IOS Software, ME340x Software (ME340x-METROIPACCESSK9-M), Version &lt;version_id&gt;, RELEASE SOFTWARE (fc1)
Technical Support: http://www.cisco.com/techsupport
Copyright (c) 1986-2016 by Cisco Systems, Inc.
Compiled Thu 21-Apr-16 01:18 by prod_rel_team
</pre>
---

##### Unit

Link to github : [ios-unit](https://github.com/FRINXio/cli-units/tree/master/ios/platform)

### Cisco IOS XE 15, 16, 17

#### CLI

---
<pre>
XE3#show inventory
NAME: "&lt;component_name&gt;", DESCR: "&lt;component_description&gt;"
PID: &lt;component_pid&gt;  , VID: &lt;component_vid&gt;  , SN: &lt;component_sn&gt;

XE3#show version
Cisco IOS XE Software, Version &lt;version_id&gt;
Cisco IOS Software [Gibraltar], ASR920 Software (PPC_LINUX_IOSD-UNIVERSALK9_NPE-M), Version &lt;software_version&gt;, RELEASE SOFTWARE (fc5)
Technical Support: http://www.cisco.com/techsupport
Copyright (c) 1986-2020 by Cisco Systems, Inc.
Compiled Thu 09-Jul-20 17:13 by mcpre
</pre>
---

##### Unit

Link to github : [ios-xe-unit](https://github.com/FRINXio/cli-units/tree/master/ios-xe/platform)

### Ciena SAOS 6

#### CLI

<pre>
Ciena_saos6&gt; chassis show power
+------------- POWER SUPPLY STATUS ----------------------+
| Module           | Part Number  | Type       | State   |
+------------------+--------------+------------+---------+
| &lt;component_name&gt; | &lt;power_pn&gt;   | AC         | Online  |
+------------------+--------------+------------+---------+


+---------------- POWER SUPPLY PSA -----------------+
| Parameter                 | Value                 |
+---------------------------+-----------------------+
| Part Number               | &lt;power_pn&gt;            |
| Serial Number             | &lt;power_sn&gt;            |
| Revision                  | &lt;power_rev&gt;           |
| CLEI Code                 |                       |
| Manufactured Date         |                       |
| Input                     |                       |
| Input Voltage             |                       |
| Output Voltage            |                       |
| Manufacturing Location    |                       |
| Checksum                  |                       |
+---------------------------+-----------------------+

Ciena_saos6&gt; port xcvr show
+-------------------+-----+-----+---------Transceiver-Status------------+-----+----------------+----+
|                   |Admin| Oper|                                       |Ciena|Ether Medium &  |Diag|
|Port               |State|State|      Vendor Name & Part Number        | Rev |Connector Type  |Data|
+-------------------+-----+-----+---------------------------------------+-----+----------------+----+
|&lt;component_name&gt;   |Ena  |UCTF |&lt;vendor_name&gt;                          |     |1000BASE-LX/LC  |Yes |
+-------------------+-----+-----+---------------------------------------+-----+----------------+----+

ciena_saos6&gt; port xcvr show port &lt;component_name&gt; vendor
+-------------------------- XCVR VENDOR DATA - Port &lt;component_name&gt; ---------------+
| Parameter                | Value              | Decoded String Equivalent         |
+--------------------------+--------------------+-----------------------------------+
| Identifier               |                    |                                   |
| Ext. Identifier          |                    |                                   |
| Connector                |                    |                                   |
+--------------------------+--------------------+-----------------------------------+
| Transceiver Codes        |                    |                                   |
|  - 10 GbE Compliance     |                    |                                   |
|  - SONET Compliance      |                    |                                   |
|  - Ethernet Compliance   |                    |                                   |
|  - Link Length           |                    |                                   |
|  - Transmitter Technology|                    |                                   |
|  - Transmission Media    |                    |                                   |
|  - Channel speed         |                    |                                   |
+--------------------------+--------------------+-----------------------------------+
| Encoding                 |                    |                                   |
| BR, Nominal              |                    |                                   |
|--------------------------+--------------------+-----------------------------------|
| Length(9um fiber) 1km    |                    |                                   |
| Length(9um fiber) 100m   |                    |                                   |
| Length(50um) 10m         |                    |                                   |
| Length(62.5um) 10m       |                    |                                   |
| Length(copper) 1m        |                    |                                   |
|--------------------------+--------------------+-----------------------------------|
| Vendor Name              | CISCO-OEM          |                                   |
| Vendor OUI               | 0x009065           |                                   |
| Vendor PN                | &lt;port_vendor_pn&gt;   |                                   |
| Vendor Revision          | &lt;port_vendor_rev&gt;  |                                   |
| Vendor Serial Number     | &lt;port_vendor_sn&gt;   |                                   |
| Vendor CLEI Code         |                    |                                   |
| Ciena PN                 |                    |                                   |
| Ciena Revision           |                    |                                   |
| Wavelength               |                    |                                   |
|--------------------------+--------------------+-----------------------------------|
| Options                  |                    |                                   |
|  - Tunable               |                    |                                   |
|  - RATE_SELECT           |                    |                                   |
|  - TX_DISABLE            |                    |                                   |
|  - TX_FAULT              |                    |                                   |
|  - Loss of Signal Invert |                    |                                   |
|  - Loss of Signal        |                    |                                   |
|--------------------------+--------------------+-----------------------------------|
| BR, max                  |                    |                                   |
| BR, min                  |                    |                                   |
| Date (mm/dd/yy)          |                    |                                   |
|--------------------------+--------------------+-----------------------------------|
| Diag Monitor Type        |                    |                                   |
|  - Legacy diagnostics    |                    |                                   |
|  - Diagnostics monitoring|                    |                                   |
|  - Internally calibrated |                    |                                   |
|  - Externally calibrated |                    |                                   |
|  - Rx power measurement  |                    |                                   |
|--------------------------+--------------------+-----------------------------------|
| Enhanced Options         |                    |                                   |
|  - Alarm/Warning Flags   |                    |                                   |
|  - Soft TX_DISABLE       |                    |                                   |
|  - Soft TX_FAULT         |                    |                                   |
|  - Soft RX_LOS           |                    |                                   |
|  - Soft RATE_SELECT      |                    |                                   |
|--------------------------+--------------------+-----------------------------------|
| SFF-8472 Compliance      |                    |                                   |
+--------------------------+--------------------+-----------------------------------+

Ciena_saos6&gt; chassis show device-id
+---------------- CHASSIS DEVICE ID ----------------+
| Parameter                 |                       |
+---------------------------+-----------------------+
| Device Type               |                       |
| Part Number/Revision      |                       |
| Serial Number             | &lt;device_sn&gt;           |
| Manufactured Date         |                       |
| CLEI Code                 |                       |
| Location of Manufacture   |                       |
| Chassis MAC Address       |                       |
| Param Version             | &lt;param_version&gt;       |
+---------------------------+-----------------------+

Ciena_saos6&gt; software show
+------------------------------------------------------------------------------+
| Installed Package   :                                                        |
| Running Package     : &lt;running_package&gt;                                      |
| Application Build   :                                                        |
| Package Build Info  :                                                        |
| Running Kernel      :                                                        |
| Running MIB Version :                                                        |
| Release Status      : GA                                                     |
+------------------------------------------------------------------------------+
| Running bank        : A                                                      |
| Bank package version:                                                        |
| Bootloader version  :                                                        |
| Bootloader status   : valid                                                  |
| Bank status         : valid                                                  |
| Standby bank        : B                                                      |
| Bank package version:                                                        |
| Bootloader version  :                                                        |
| Bootloader status   : valid                                                  |
| Bank status         : valid                                                  |
+------------------------------------------------------------------------------+
| Last command file:                                                           |
| Last configuration file:                                                     |
+------------------------------------------------------------------------------+

Ciena_saos6&gt; chassis show capabilities
+----------------------------------- PLATFORM CAPABILITIES --------------------------+
| Parameter                        | Value                                           |
+----------------------------------+-------------------------------------------------+
| Capabilities Class               |                                                 |
| Platform Type                    |                                                 |
| Platform Name                    | &lt;platform_name&gt;                                 |
| Platform Description             | &lt;platform_description&gt;                          |
| No. Slots                        |                                                 |
| Primary Ctrl Blade               |                                                 |
| No. Fan Trays                    |                                                 |
| No. Fans Per Tray                |                                                 |
| Fixed DC Power                   |                                                 |
| Redundant Power                  |                                                 |
| Max Physical Ports               |                                                 |
| Max LAG Ports                    |                                                 |
| Max Ports Per LAG                |                                                 |
| Max IP Interfaces                |                                                 |
| Max VLANs                        |                                                 |
| VLAN Translation                 |                                                 |
| Max VLAN Cross Connections       |                                                 |
| Global Inner TPID Configuration  |                                                 |
| Max IGMP Snoop Service Instances |                                                 |
| Max Mcast Groups                 |                                                 |
| Max Mcast Source Addrs           |                                                 |
| Max Mcast Source Addrs Per Grp   |                                                 |
| Max Mcast Logical Interfaces     |                                                 |
| Max Mcast Member Interfaces      |                                                 |
| Max MSTIs                        |                                                 |
| Max RSTP Domains                 |                                                 |
| Max PM Instances                 |                                                 |
| Max PM Bins (Class 0)            |                                                 |
| Max PM Bins (Class 1)            |                                                 |
| Max PM Interval Profiles         |                                                 |
| Protocol Filters                 |                                                 |
| Max MPLS Ingress Tunnels         |                                                 |
| Max MPLS Egress Tunnels          |                                                 |
| Max MPLS Transit Tunnels         |                                                 |
| Max MPLS VCs                     |                                                 |
| Max MPLS L2VPNs                  |                                                 |
| Max MPLS VSs                     |                                                 |
|   Max MPLS VPWS VSs              |                                                 |
|   Max MPLS VPLS VSs              |                                                 |
| Max Ethernet VCs                 |                                                 |
| Max Default VSs                  |                                                 |
| Max VSs                          |                                                 |
| Max VS Subs                      |                                                 |
| VS Subs Statistics Collection    |                                                 |
| Max VS Subs with Stats           |                                                 |
| Max L2-CFT Profiles              |                                                 |
| Max Tagged PVST L2PT Instances   |                                                 |
| VC Transforms                    |                                                 |
|   Max VC L2 Transforms           |                                                 |
|   Max VCs with L2 Transform      |                                                 |
| Egress Bandwidth Shaping         |                                                 |
| Multi Subs Per Port              |                                                 |
| Max Redundancy Groups            |                                                 |
| Max Links per Redundancy Group   |                                                 |
| VPLS FPGA Support                |                                                 |
| PBT FPGA Support                 |                                                 |
| L2 MAC Table Expansion           |                                                 |
| Max DYNA-SA Entries              |                                                 |
| Max FSMT Entries                 |                                                 |
| Max SRVC-LVL Entries             |                                                 |
| Max L2-SAC Entries               |                                                 |
| Max SMT Entries                  |                                                 |
| Max EPR Snids                    |                                                 |
| Ring Protection                  |                                                 |
| Max Logical Rings                |                                                 |
| Max Virtual Rings                |                                                 |
| Network Sync                     |                                                 |
| BITS Timing                      |                                                 |
| GPS Timing                       |                                                 |
| PTP Timing                       |                                                 |
| Dying Gasp                       |                                                 |
| Benchmark                        |                                                 |
| Max Benchmark Bandwidth (Mbps)   |                                                 |
| Benchmark Reflector              |                                                 |
| Benchmark Generator              |                                                 |
| Max Benchmark Entities           |                                                 |
| Max Benchmark Concurrent Tests   |                                                 |
| Max Benchmark Test Inst Config   |                                                 |
| Max Benchmark Test Inst Enabled  |                                                 |
| Max Benchmark Profiles Config    |                                                 |
| Max Benchmark BW Profiles Config |                                                 |
| Max Benchmark KPI Profiles Config|                                                 |
| Max Benchmark EMIX Sequences     |                                                 |
| Max Benchmark Unique Active CVIDs|                                                 |
| Max ACL Profile Definitions      |                                                 |
| Max ACL Rule Definitions         |                                                 |
| Max DHCP Relay Agents            |                                                 |
| Auxiliary Ping                   |                                                 |
| MPLS VPLS IRB                    |                                                 |
|   Max VPLS IRB Ports             |                                                 |
| Global RCOS->FCOS Maps           |                                                 |
| L2-Only RCOS->FCOS Maps          |                                                 |
| MEF Envelope Ingress Metering    |                                                 |
| IP ECMP                          |                                                 |
|   Max IP ECMP Groups             |                                                 |
| Linear APS                       |                                                 |
|   Max Linear APS Groups          |                                                 |
| Max IP-ACL Rule Definitions      |                                                 |
+----------------------------------+-------------------------------------------------+
</pre>

##### Unit

Link to github : [saos6-unit](https://github.com/FRINXio/cli-units/tree/master/saos/saos-6/saos-6-platform)

### Ciena SAOS 8

#### CLI

---
<pre>
SAOS8&gt; chassis device-id show
+---------------- CHASSIS DEVICE ID ------------------+
| Parameter                 |                         |
+---------------------------+-------------------------+
| Ethernet Base Address     | &lt;eth_base_address&gt;      |
| Eth Address Block Size    | &lt;eth_address_block_size&gt;|
| Module Serial Number      | &lt;module_sn&gt;             |
| Model Part Number         | &lt;model_pn&gt;              |
| Model Revision            | &lt;model_rev&gt;             |
| Product ID                | &lt;product_id&gt;            |
| Manufactured Date         | &lt;manufactured_date&gt;     |
| CLEI Code                 | &lt;clei_code&gt;             |
| Bar Code                  | &lt;bar_code&gt;              |
| Backplane Assy Serial Num | &lt;backplane_assy_sn&gt;     |
| Backplane Assy Part Number| &lt;backplane_assy_pn&gt;     |
| Backplane Assy Revision   | &lt;backplane_assy_rev&gt;    |
| Backplane Serial Number   | &lt;backplane_sn&gt;          |
| Backplane Part Number     | &lt;backplane_pn&gt;          |
| Backplane Revision        | &lt;backplane_rev&gt;         |
| Software Compatibility    | &lt;software_compatibility&gt;|
| Functional Test Count     | &lt;functional_test_count&gt; |
+---------------------------+-------------------------+

+---------- MODULE DEVICE ID SLOT LM1      --------------+
| Parameter                 | Value                      |
+---------------------------+----------------------------+
| CPU Board                 |                            |
|  Ethernet Base Address    | &lt;cpu_eth_base_addr&gt;        |
|  Eth Address Block Size   | &lt;cpu_eth_addr_block&gt;       |
|  Module Serial Number     | &lt;cpu_module_sn&gt;            |
|  Model Part Number        | &lt;cpu_model_pn&gt;             |
|  Model Revision           | &lt;cpu_cpu_model_rev&gt;        |
|  Product ID               | &lt;cpu_product_id&gt;           |
|  Manufactured Date        | &lt;cpu_cpu_manufactured_date&gt;|
|  CLEI Code                | &lt;cpu_clei_code&gt;            |
|  Bar Code                 | &lt;cpu_bar_code&gt;             |
|  Board Serial Number      | &lt;cpu_board_sn&gt;             |
|  Board Part Number        | &lt;cpu_board_pn&gt;             |
|  Board Revision           | &lt;cpu_board_rev&gt;            |
|  Software Compatibility   | &lt;cpu_soft_comp&gt;            |
|  Functional Test Count    | &lt;cpu_func_test_cnt&gt;        |
|  Fault Card               | &lt;cpu_fault_card&gt;           |
+---------------------------+----------------------------+
| Main Board                |                            |
|  Module Serial Number     | &lt;main_module_sn&gt;           |
|  Model Part Number        | &lt;main_model_pn&gt;            |
|  Model Revision           | &lt;main_model_rev&gt;           |
|  Manufactured Date        | &lt;main_manufactured_date&gt;   |
|  Board Serial Number      | &lt;main_board_sn&gt;            |
|  Board Part Number        | &lt;main_board_pn&gt;            |
|  Board Revision           | &lt;main_board_rev&gt;           |
+---------------------------+----------------------------+

+--------- MODULE DEVICE ID SLOT &lt;component_name&gt; ----+
| Parameter                 | Value                   |
+---------------------------+-------------------------+
| Ethernet Base Address     | &lt;eth_base_address&gt;      |
| Eth Address Block Size    | &lt;eth_address_block_size&gt;|
| Module Serial Number      | &lt;module_sn&gt;             |
| Model Part Number         | &lt;model_pn&gt;              |
| Model Revision            | &lt;model_rev&gt;             |
| Product ID                | &lt;product_id&gt;            |
| Manufactured Date         | &lt;manufactured_date&gt;     |
| CLEI Code                 | &lt;clei_code&gt;             |
| Bar Code                  | &lt;bar_code&gt;              |
| Board Serial Number       | &lt;board_sn&gt;              |
| Board Part Number         | &lt;board_pn&gt;              |
| Board Revision            | &lt;board_rev&gt;             |
| Software Compatibility    | &lt;software_compatibility&gt;|
| Functional Test Count     | &lt;functional_test_count&gt; |
| Fault Card                | &lt;fault_card&gt;            |
+---------------------------+-------------------------+

+--------------- DEVICE ID SLOT &lt;component_name&gt; -----+
| Parameter                 |                         |
+---------------------------+-------------------------+
| Module Serial Number      | &lt;module_sn&gt;             |
| Model Part Number         | &lt;model_pn&gt;              |
| Model Revision            | &lt;model_rev&gt;             |
| Product ID                | &lt;product_id&gt;            |
| Manufactured Date         | &lt;manufactured_date&gt;     |
| CLEI Code                 | &lt;clei_code&gt;             |
| Bar Code                  | &lt;bar_code&gt;              |
| Board Serial Number       | &lt;board_sn&gt;              |
| Board Part Number         | &lt;board_pn&gt;              |
| Board Revision            | &lt;board_rev&gt;             |
| Software Compatibility    | &lt;software_compatibility&gt;|
| Functional Test Count     | &lt;functional_test_count&gt; |
+---------------------------+-------------------------+

+----------------- &lt;component_name&gt; DEVICE ID --------+
| Parameter                 | Value                   |
+---------------------------+-------------------------+
| Module Serial Number      | &lt;module_sn&gt;             |
| Model Part Number         | &lt;model_pn&gt;              |
| Model Revision            | &lt;model_rev&gt;             |
| Product ID                | &lt;product_id&gt;            |
| Manufactured Date         | &lt;manufactured_date&gt;     |
| CLEI Code                 | &lt;clei_code&gt;             |
| Bar Code                  | &lt;bar_code&gt;              |
| Board Serial Number       | &lt;board_sn&gt;              |
| Board Part Number         | &lt;board_pn&gt;              |
| Board Revision            | &lt;board_rev&gt;             |
| Software Compatibility    | &lt;software_compatibility&gt;|
| Functional Test Count     | &lt;functional_test_count&gt; |
+---------------------------+-------------------------+
</pre>
---

##### Unit

Link to github : [saos8-unit](https://github.com/FRINXio/cli-units/tree/master/saos/saos-6/saos-8-platform)

### CER Arris devices

#### CLI

---
<pre>
CER#show license
system-legal-intercept        : &lt;license_system_legal_intercept&gt;
system-principal-core         : &lt;license_system_principal_core&gt;
system-auxiliary-core         : &lt;license_system_aux_core&gt;
system-laes                   : &lt;license_system_laes&gt;
system-calea                  : &lt;license_system_calea&gt;
system-lld-us-asf             : &lt;license_lld_us_asf&gt;
system-us-pgs                 : &lt;license_system_us_pgs&gt;

Chassis Serial Number: &lt;license_chassis_serial_number&gt;

CER#show LLDP
Global LLDP Information:
    Status: &lt;lldp_status&gt;
    LLDP advertisements are sent every &lt;lldp_ad_interval&gt;
    LLDP hold time advertised is &lt;lldp_ad_hold_time&gt;

CER#show port transceiver
slot/port: &lt;component_name&gt;
  tType        : &lt;transceiver_t_type&gt;
  speed        : &lt;transceiver_speed&gt;
  type         : &lt;transceiver_type&gt;
  vendor       : &lt;transceiver_vendor&gt;
  partNumber   : &lt;transceiver_part_number&gt;
  revision     : &lt;transceiver_revision&gt;
  serialNumber : &lt;transceiver_serial_number&gt;
  dateCode     : &lt;transceiver_date_code&gt;
  temperature  : &lt;transceiver_temperature&gt;
  voltage      : &lt;transceiver_voltage&gt;
  Ch 0 txBias  : &lt;transceiver_ch_0_tx_bias&gt;
  Ch 0 txPower : &lt;transceiver_ch0_tx_power&gt;
  Ch 0 rxPower : &lt;transceiver_ch0_rx_power&gt;

CER#show version chassis detail
Chassis Type: &lt;chassis_type&gt;
  Model Name:          &lt;chassis_model_name_type&gt;
  Model Version:       &lt;chassis_model_version_type&gt;
  Serial Number:       &lt;chassis_serial_number_type&gt;
Module:   &lt;component_name&gt;
  Model Name:          &lt;chassis_model_name&gt;
  Model Version:       &lt;chassis_model_version&gt;
  Serial Number:       &lt;chassis_serial_number&gt;

CER#show version detail
Chassis Type: &lt;chassis_type&gt;
Time since the CMTS was last booted: &lt;version_last_booted_time&gt;
Slot:   &lt;component_name&gt;
  Type:                &lt;version_type&gt;
  Model Name:          &lt;version_model_name&gt;
  Model Version:       &lt;version_model_version&gt;
  Serial Number:       &lt;version_serial_number&gt;
  CPU Speed:           &lt;version_cpu_speed&gt;
  Bus Speed:           &lt;version_bus_speed&gt;
  RAM Size:            &lt;version_ram_size&gt;
  NOR  Flash Size:     &lt;version_nor_flash_size&gt;
  NAND Flash Size:     &lt;version_nand_flash_size&gt;
  PIC Model Name:      &lt;version_pic_model_name&gt;
  PIC Model Version:   &lt;version_pic_model_version&gt;
  PIC Serial Number:   &lt;version_pic_serial_number&gt;
  Firmware Version:    &lt;version_firmware_version&gt;
  Active SW:           &lt;version_active_sw&gt;
  Active Patch:        &lt;version_active_patch&gt;
  Reason Last Booted:  &lt;version_reason_last_booted&gt;
  Uptime:              &lt;version_uptime&gt;
</pre>
---

##### Unit

Link to github : [ios-unit](https://github.com/FRINXio/cli-units/tree/master/cer/platform)