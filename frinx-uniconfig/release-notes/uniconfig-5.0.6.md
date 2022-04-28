---
order: 9
---
# UniConfig 5.0.6

## :white_check_mark: New Features

### Expose operational data about transactions

It would improve visibility what transactions are open on uniconfig instance - when these transactions have been open and what nodes have been changed in the transaction.

Transaction data:

- identifier (uuid)
- trace id / different parameter (once we support tracing)
- creation time
- last access time
- idle timeout, hard timeout
- list of changed nodes (incl. topologies)
- additional context (random string, text column)

### Implement metric collection and reporting in Uniconfig

Collect and report metrics such as:

- TX pre minute
- RPC calls per minute
- Task execution queue size
- Netconf msg sent count
- CLI command sent count
- …

Reporting part could be just logging the state of metrics for the time being

### Collect open transactions data in collect_diag_info.sh

Please enhance debug collection script to collect details of following
+ Open Transaction , Read or Read-Write and if possible module which has opened the transaction

For example, this is how NCS displays.

```
sessionId=6 2022-03-25 04:51:53 system@0.0.0.0 system/system
no locks set
transactions:
tid=1 db=running mode=read
```

This could help in debugging slowness issues caused if there is any transaction leak.

## :bulb: Improvements

### Set OWASP dependency check plugin to level 9

- decrease owasp level to 9 (in distribution/packaging/zip pom)
- fix all dependency issues so that uniconfig will successfully build

### CLI UC shell - show transaction log in ordered list & add "brief option"

Currently we display the transaction log as a json without ordering. 
We should assume that the transaction log can become very large and should still be manageable to display. 
Hence we are proposing the following improvements:

- always show the transaction log as an ordered list. Order by transaction timestamp. The most recent transaction should be at the bottom of the list.
- add a "brief" option to that command and display only one line per transaction log. Similar like this 

## :x: Bug Fixes

### OpenAPI .yaml file generating incorrectly

[Build, Collaborate & Integrate APIs | SwaggerHub](https://app.swaggerhub.com/apis-docs/Frinx/uniconfig/latest#/cli-unit-generic/rpc_cli-unit-generic%3Aexecute-and-read)

cli-unit-general API yaml seems incorrectly generated, URIs are wrong

### SYST_ data-change-subscriptions?content=nonconfig not working

Based on documentation [!ref text="Kafka notifications"](../user-guide/uniconfig-operations/kafka-notifications/#subscription-to-data-change-events)

test:

```
DEBUG    urllib3.connectionpool:connectionpool.py:428 http://127.0.0.1:8181 "GET /rests/data/network-topology:network-topology/topology=uniconfig/node=versa_20/data-change-subscriptions?content=nonconfig HTTP/1.1" 400 651
```
```
DEBUG    uniconfig:uniconfig.py:183 response: 400 {"errors":{"error":[{"error-message":"Could not parse path 'network-topology:network-topology/topology=uniconfig/node=versa_20/data-change-subscriptions'. Offset: '92': Node with name 'data-change-subscriptions' cannot be found under node: (urn:TBD:params:xml:ns:yang:network-topology?revision=2013-10-21)node. Candidate data children nodes: crypto:hash, frinx-uniconfig-topology:status-message, node-id, frinx-uniconfig-topology:connection-status, termination-point, supporting-node, frinx-uniconfig-topology:configuration, frinx-configuration-metadata:configuration-metadata, crypto:crypto.","error-tag":"unknown-element","error-type":"protocol"}]}}
```

test here https://gerrit.frinx.io/c/system-tests/+/13155

```
url = "/data-change-subscriptions"

    response = uc_request(odl_ip, "GET", "uniconfig", node, url + "?content=nonconfig", cookies={})
    assert response.ok
✘ kristina@kristina  ~/system-tests  ➦ 1858669 ±  pytest unative/notification_kafka/notification/t
```
