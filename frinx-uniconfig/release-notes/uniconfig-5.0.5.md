---
order: 13
---

# UniConfig 5.0.5

## :bulb: Improvements

### Reconfigure swagger generator for versa to produce desired depths for all APIs

Since we need to create APIs with depth 4, I have noticed APIs are created to the last container when the depth of yang is less than 4. 
Can you make API is not generated for the last container, for example 2nd API in the below not required as “global” is the leaf container. 
This change will reduce size of yaml file and number of APIs

```
/data/network-topology:network-topology/network-topology:topology={topology-id}/network-topology:node={node-id}/frinx-uniconfig-topology:configuration/predefined:predefined
{
  "predefined:predefined": {
    "global": {
      "init": true
    }
  }
}
```

```
/data/network-topology:network-topology/network-topology:topology={topology-id}/network-topology:node={node-id}/frinx-uniconfig-topology:configuration/predefined:predefined/predefined:global
{ 
  "predefined:global": {
    "init": true
  }
}
```

## :x: Bug Fixes

### Uniconfig transaction is not thread-safe

It is not safe to use same uniconfig transaction simultaneously by multiple user-side threads because underlying database connection/transaction is not thread-safe in case of PostgreSQL driver and UniConfig is not doing any additional synchronisation.

Read: [Chapter 10. Using the Driver in a Multithreaded or a Servlet Environment](https://jdbc.postgresql.org/documentation/head/thread.html)

Behaviour that was also observed in UniConfig (it is Oracle DB, but symptoms are similar): [Working with multiple threads sharing a single connection](https://docs.oracle.com/javadb/10.8.3.0/devguide/cdevconcepts23499.html)

### Failed to find node '<node>' in the topology 'uniconfig'

It happened already a couple of times when a workflow task failed during the execution of getting data from the device. 
In VFZ we have a specific task for this operation called `uniconfig_read_structured_device_data` which gets a specific config from the device

```
https://uniconfig:8181/rests/data/network-topology:network-topology/topology=uniconfig/node=mnd-gt0001-ds511/frinx-uniconfig-topology:configuration/
frinx-openconfig-ring:logical-rings/logical-ring
```

During this execution, there were other devices running in the parallel executing the same task and 2 `read_and_execute_rpc_cli` tasks too.

```
https://uniconfig:8181/rests/operations/network-topology:network-topology/topology=cli/node=mnd-gt0001-ds511/yang-ext:mount/cli-unit-generic:execute-and-read
```

The device had the records in the node and mounpoint tables in the UC DB.


DONE, MOVE TO 5.0.4