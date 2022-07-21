# Performance characteristics

This page contains reference performance characteristics for Uniconfig.

Following sections contain performance characteristics considering a single node of Uniconfig.

Important caveats:
- Measurement were performed on simulated devices = no device overhead
- Measurement were performed on a local network = no network overhead
- Measured on Uniconfig version 5.0.12
- 

## Device installation & synchronization 

This section provides details on how fast can a certain number of devices with a certain amount of configuration
be installed and fully synced by a single Uniconfig instance.

The unit of measurement is: Number of configuration lines / per single CPU core / per minute.
This number can then be roughly applied to any other similar device being installed by uniconfig.

### CLI devices

There are 2 main families of CLI devices: those using Cisco style configuration (configuration in sections)
and devices that use one-line style of configuration (without sections) such as Ciena SAOS 8.

It is important to distinguish performance characteristics of these 2 families. 

#### One-line style of configuration
Devices running SAOS operating system (Ciena) and similar

Installation & sync rate:

**60,637** *lines of json / per core / per minute*

or

**4,929** *lines of raw cli configuration / per core / per minute*

> A single uniconfig node is capable of installing (and fully syncing)
> **100 Ciena (SAOS 8) devices with 15k lines of configuration** (~ 123k lines of formatted json in Uniconfig)
> in **50 minutes** using **4 CPU cores**

Recommended batch size for parallel installation in such case would be about 50 devices per batch as the parallelism is limited by the number of available cores.

#### Tree-like style of configuration
Cisco style of confituration (IOS, IOS-XR etc.)

// TBD

### Netconf devices

// TBD

## Device configuration

### CLI devices

// TBD

### Netconf devices

// TBD
