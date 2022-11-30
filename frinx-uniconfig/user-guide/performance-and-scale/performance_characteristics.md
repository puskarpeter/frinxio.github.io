# Performance characteristics

This page contains reference performance characteristics for Uniconfig.

We try to answer the question how fast can a certain number of devices with a certain amount of configuration
be installed and fully synced by
- a single Uniconfig instance
- 3-node Uniconfig deployment with load balancer

The unit of measurement is: Number of configuration lines / per single CPU core / per minute.
This number can then be roughly applied to any other similar device being installed by uniconfig.

## CLI devices

There are 2 main families of CLI devices: those using Cisco style configuration (configuration in sections)
and devices that use one-line style of configuration (without sections) such as Ciena SAOS 8.

It is important to distinguish performance characteristics of these 2 families. 

## Netconf devices

// TBD

## Tree-like style of configuration
Cisco style of confituration (IOS, IOS-XR etc.)

// TBD


## One-line style of configuration devices (SAOS) performance tests

Important caveats:
- Measurement were performed on simulated devices = no device overhead
- Measurement were performed on a local network = no network overhead
- Measured on Uniconfig version 5.0.12
- Simulated devices were of two flawors: half with small configuration and the half with big configuration

Tests:
- A. Single node deployment of Uniconfig resources: CPU 4 cores and RAM 4 GB
- B. 3 node deployment of Uniconfig - resources per node: CPU 4 cores and RAM 4 GB
- C. 3 node deployment of Uniconfig - resources per node: CPU 6 cores and RAM 4 GB

### Device installation & synchronization 

                        "input": { 
                            "cli": {
                                "cli-topology:device-type": "saos",
                                "cli-topology:device-version": "6",
                                "cli-topology:dry-run-journal-size": 180,
                                "cli-topology:host": "172.16.62.119",
                                "cli-topology:journal-size": 500,
                                "cli-topology:keepalive-delay": "900",
                                "cli-topology:keepalive-timeout": "3600",
                                "cli-topology:parsing-engine": "one-line-parser",
                                "cli-topology:password": "*****",
                                "cli-topology:port": "22",
                                "cli-topology:transport-type": "ssh",
                                "cli-topology:username": "*****",
                                "node-extension:reconcile": false,
                                "uniconfig-config:install-uniconfig-node-enabled": true
                            },
                            "node-id": "ASN-RC0002-DS119"
                        }

                        "input": { 
                            "cli": {
                                "cli-topology:device-type": "saos",
                                "cli-topology:device-version": "8",
                                "cli-topology:dry-run-journal-size": 180,
                                "cli-topology:host": "172.16.84.86",
                                "cli-topology:journal-size": 500,
                                "cli-topology:keepalive-delay": "900",
                                "cli-topology:keepalive-timeout": "3600",
                                "cli-topology:parsing-engine": "one-line-parser",
                                "cli-topology:password": "*****",
                                "cli-topology:port": "22",
                                "cli-topology:transport-type": "ssh",
                                "cli-topology:username": "*****",
                                "node-extension:reconcile": false,
                                "uniconfig-config:install-uniconfig-node-enabled": true
                            },
                            "node-id": "ASN-RC0002-CS598"
                        }
 

### Test A - one node Uniconfig
Devices running SAOS operating system (Ciena) and similar

Inputs:  
375 x SAOS 6 devices configuration:
8834 json lines = 1510 cli config lines (brief config)

375 x SAOS 8 devices configuration:
277375 json lines = 30705  cli config lines (brief config)

Evaluation:
750 devices were registered in 7.5 hours on single node Uniconfig using 4 cores  
Average one device instalation duration = (7.5 * 60 minutes) / 750 devices = 0.6 minutes  
Average number of json lines per device = (8834 + 277375)/2 = 143104 lines  
lines of json / per core / per minute = 143104 lines / 4 cores / 0.6 minutes = 59626  
Average number of cli lines per device = (1510 + 30705)/2 = 16107,5 lines  
lines of cli / per core / per minute = 16107,5 lines / 4 cores / 0.6 minutes = 6711  

Installation & sync rate:

**59,626** *lines of json / per core / per minute*

or

**6,711** *lines of raw cli configuration / per core / per minute*

> A single uniconfig node is capable of installing (and fully syncing)
> **100 Ciena (SAOS 8) devices with 15k lines of configuration** (~ 123k lines of formatted json in Uniconfig)
> in **55 minutes** using **4 CPU cores**

Recommended batch size for parallel installation in such case would be about 50 devices per batch as the parallelism is limited by the number of available cores.

### Test B - 3 nodes of Uniconfig with load balancer

Devices running SAOS operating system (Ciena) and similar

Inputs:  
750 x SAOS 6 devices configuration:
8834 json lines = 1510 cli config lines (brief config)

750 x SAOS 8 devices configuration:
277375 json lines = 30705  cli config lines (brief config)

Evaluation for 4 core deployment:
1500 devices were registered in 5.5 hours on 3 node Uniconfig deployment each using 4 cores  
Average one device instalation duration = (5.5 * 60 minutes) / 1500 devices = 0.22 minutes  
Average number of json lines per device = (8834 + 277375)/2 = 143104 lines  
lines of json / per core / per minute = 143104 lines / 3*4 cores / 0.22 minutes = 54206  
Average number of cli lines per device = (1510 + 30705)/2 = 16107,5 lines  
lines of cli / per core / per minute = 16107,5 lines / 3*4 cores / 0.22 minutes = 6101  

Installation & sync rate:

**54,206** *lines of json / per core / per minute*

or

**6,101** *lines of raw cli configuration / per core / per minute*

> A 3 nodes of uniconfig with loadbalancer are capable of installing (and fully syncing)
> **100 Ciena (SAOS 8) devices with 15k lines of configuration** (~ 123k lines of formatted json in Uniconfig)
> in **19 minutes** using **12 CPU cores**

Recommended batch size for parallel installation in such case would be about 150 devices per batch as the parallelism is limited by the number of available cores.

### Test C - 3 nodes of Uniconfig with load balancer

Devices running SAOS operating system (Ciena) and similar

Inputs:  
750 x SAOS 6 devices configuration:
8834 json lines = 1510 cli config lines (brief config)

750 x SAOS 8 devices configuration:
277375 json lines = 30705  cli config lines (brief config)

Evaluation for 6 core deployment:
1500 devices were registered in 3.7 hours on 3 node Uniconfig deployment each using 6 cores  
Average one device instalation duration = (3.7 * 60 minutes) / 1500 devices = 0.148 minutes  
Average number of json lines per device = (8834 + 277375)/2 = 143104 lines  
lines of json / per core / per minute = 143104 lines / 3*6 cores / 0.148 minutes = 53717  
Average number of cli lines per device = (1510 + 30705)/2 = 16107,5 lines  
lines of cli / per core / per minute = 16107,5 lines / 3*6 cores / 0.148 minutes = 6046  

Installation & sync rate:

**53,717** *lines of json / per core / per minute*

or

**6,046** *lines of raw cli configuration / per core / per minute*

> A 3 nodes of uniconfig with loadbalancer are capable of installing (and fully syncing)
> **100 Ciena (SAOS 8) devices with 15k lines of configuration** (~ 123k lines of formatted json in Uniconfig)
> in **13 minutes** using **18 CPU cores**


Recommended batch size for parallel installation in such case would be about 150 devices per batch as the parallelism is limited by the number of available cores.
