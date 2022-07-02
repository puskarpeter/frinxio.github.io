# UniConfig Clustering

## Introduction

UniConfig can be easily deployed in the cluster because of its stateless and transaction-based architecture:

* stateless architecture - UniConfig nodes in the cluster don't keep any state that would have to be synced directly
  with other nodes in the cluster. All network-topology configuration and state information are stored inside
  PostgreSQL database that must be reachable from all UniConfig nodes in the same zone.
* transaction-based architecture - Load-balancing is based on allocation of UniConfig transactions to nodes
  in the cluster. The same UniConfig transaction cannot span multiple UniConfig nodes in the cluster.
  Sessions used for management of devices are temporary - they are created when UniConfig needs to access device
  on the network, and they are closed when UniConfig transactions, that used corresponding sessions, is closed.

There are several advantages of clustered deployment of UniConfig nodes:

* horizontal scalability - Increasing number of units that can process UniConfig transactions in parallel.
  Single UniConfig node tend to have limited processing and networking resources - by increasing number of nodes in the
  cluster, this constraint can be mitigated. Number of connected UniConfig nodes in the cluster can also be adjusted
  at the runtime.
* high-availability - Single UniConfig node doesn't represent single point of failure. If UniConfig node crashes,
  only UniConfig transactions that are processed by corresponding node, are cancelled. Application can retry failed
  transaction, and it will be processed by next node in the cluster.

## Deployments

### Single-zone deployment

In the single-zone deployment, all managed network devices are reachable by all UniConfig nodes in the cluster - zone.
Components of the single-zone deployment and connections between them are depicted by the next diagram.

![Deployment with single zone](single-zone-architecture.svg)

Description of components:
* UniConfig controllers - Network controllers that use common PostgreSQL system for persistence of data, communicate
  with network devices using NETCONF/GNMi/CLI management protocols, and propagate notifications into Kafka topics
  (UniConfig nodes act only as Kafka producers). UniConfig nodes do not communicate with each other directly,
  their operation can only be coordinated by  operational data stored in the database in case of NETCONF streams.
* Database storage - PostgreSQL is used for persistence of network-topology configuration, mountpoints settings,
  and selected operational data. PostgreSQL database can also be deployed in the cluster.
* Message and notification channels - Kafka cluster is used for propagation of notifications that are generated
  from UniConfig nodes themselves (e.g., audit and transaction notifications) or from devices and only propagated
  by UniConfig controller.
* Load-balancers - Load-balancer is used for distribution of transactions (HTTP traffic) and SSH sessions
  from applications to UniConfig nodes. From the view of load-balancer, all UniConfig nodes in the cluster can process
  transactions and operations in the transactions equally. Currently, only round-robin load-balancing strategy
  is supported. Load-balancers can also be connected in the cluster to improve high-availability of this layer 
  in the deployment.
* Managed network devices - Devices that are managed using NETCONF/GNMi/CLI protocols by UniConfig nodes or generate
  notifications to UniConfig nodes. Sessions between UniConfig nodes and devices are either on-demand/temporary
  (configuration of devices) or long-term (distribution of notifications over streams).
* HTTP / SSH clients & Kafka consumers - Application layer that may contain workflow management systems or directly
  end-user systems. RESTCONF API is exposed using HTTP protocol, SSH server is exposing UniConfig shell,
  and Kafka brokers allows Kafka consumers to listen to the events on subscribed topics.

### Multi-zone deployment

In this type of deployment there are multiple zones that manage separated sets of devices because of several reasons:

* network reachability issues - groups of devices are only reachable and thus manageable from some part
  of the network (zone) but not from others
* logical separation - there are different scaling strategies or requirements for different zones
* legal issues - some devices must be managed separately with split storage, for example, because of the regional
   restrictions

The following diagrams represents the sample deployment with 2 zones. The first zone contains of 3 UniConfig nodes,
the second zone contains only from 2 UniConfig nodes. Zones share the Kafka cluster; database systems are split.

![Deployment with multiple zones](multi-zone-architecture.svg)

Description of multi-zone areas:

* applications - In comparison to single-zone deployment there is additionally database that contains device-zone
  mappings - based on this information application decides with which zone communication happens.
* isolated zones - Zones contain set of UniConfig nodes, managed network devices, and load-balancers  
  connected in the isolated clusters. Communication between UniConfig cluster and applications is proxied
  by load-balancers the same way as within single-zone deployment.
* PostgreSQL databases - It is recommended to use dedicated database per zone, especially, if deployment requires
  working device notification streams. Otherwise, subscription allocation would not work since UniConfig nodes
  from different zones may try to establish sessions to unreachable devices placed in the neighbouring zone.
* Kafka cluster - Kafka cluster can be shared by multiple zones or there could be single Kafka cluster per zone.
  Notifications from different zones can be safely pushed to the common topics since there cannot be any
  conflicts between Kafka publishers. However, it is also possible to achieve isolation of published messages
  in the single-cluster Kafka deployment by setting different topic names in different zones.

### Load-balancer operation

The responsibility of load-balancer is to allocate UniConfig transaction on one of the UniConfig nodes in the cluster.
It is done by forwarding requests without UniConfig transaction header to one of the UniConfig nodes
(using round-robin strategy) and appending used backed identifier to the create-transaction RPC response in form
of the additional Cookie header ('sticky session' concept). Afterwards, it is responsibility of the application
to assure that requests that belong  to the same transaction contains also same backend identifier.

!!!
It is recommended to use load-balancer deployment that is stateless based on 'sticky cookie' - it does not store
mappings between transactions and context. It makes deployment more straightforward and scalability
of load-balancers more robust.
!!!

The next sequence diagram captures process of creation and usage of 2 UniConfig transactions with focus
on load-balancer operation.

![Load-balancing UniConfig transactions](load-balancing-transactions.svg)

* The first create-transaction RPC is forwarded to the first UniConfig node (applying round-robin strategy), because
  it does not contain uniconfig_server_id key in the Cookie header.
  The response contains both UniConfig transaction ID (UNICONFIGTXID) and uniconfig_server_id that represents
  'sticky cookie'. Cookie header uniconfig_server_id is appended to the response by load-balancer.
* The next request that belongs to the created transaction, contains same UNICONFIGTXID and uniconfig_server_id.
  Load balancer uses the uniconfig_server_id to forward this request to the correct UniConfig node.
* The last application request represents again create-transaction RPC. This time, request is forwarded to
  the next registered UniConfig node in the cluster according to the round-robin strategy.

## Configuration

### UniConfig configuration

All UniConfig nodes in the cluster should be configured with the same parameters. There are several important sections
of config/lighty-uniconfig-config.json file related to clustered environment.

#### Database connection settings

This section contains information how to connect to PostgreSQL database and connection pool settings. It is placed
under 'dbPersistence.connection' JSON object.

Example with essential settings:

```json database connection settings
// Grouped settings related to database connection.
"connection": {
    // name of the database
    "dbName": "uniconfig",
    // name of the user that has the remote access to database specified by 'dbName'
    "username": "uniremote",
    // user password (it is used only for the password-base authentication)
    "password": "unipass",
    // initial size of the connection pool (pre-initialized connections)
    "initialDbPoolSize": 5,
    // maximum size of the connection pool, before creation of next connections are blocked
    "maxDbPoolSize": 20,
    // maximum number of idle connections before next idle connections are cleaned
    "maxIdleConnections": 5,
    /*
    Timeout value used for socket read operations. If reading from the server takes longer than this value,
    the connection is closed. This can be used as both a brute force global query timeout and a method of
    detecting network problems. The timeout is specified in seconds and a value of 0 means that it is disabled.
    */
    "socketReadTimeout": 20,
    // maximum wait time for obtaining of a new connection before fetch request is dropped [milliseconds]
    "maxWaitTime": 30000,
    /*
    List of network locations at which target database resides. The first entry is always tried in the first
    attempt during creation of database connection. If there are multiple entries specified, then other
    locations are used as fallback method in the order in which they are specified.
    */
    "databaseLocations": [
        {
            // database hostname / IP address
            "host": "uniconfig-db",
            // TCP port on which target database listens to incoming connections
            "port": 26257
        }
    ]
}
```

!!!
Be sure that [number of UniConfig nodes in cluster] * [maxDbPoolSize] does not exceed maximum allowed number
of open transactions and open connections on PostgreSQL side. Be aware that 'maxDbPoolSize' also caps maximum
number of open UniConfig transactions (1 UniConfig transaction == 1 database transaction == 1 connection to database).
!!!

#### UniConfig node identification and heartbeat

By default, UniConfig node name is generated randomly. This behaviour can be changed by setting
'dbPersistence.uniconfigInstance.instanceName'. Instance name is leveraged, for example, in the clustering
of stream subscriptions.

UniConfig nodes reports themselves in the cluster by updating heartbeat timestamp in database. Currently, this
feature is not used by any other component in the UniConfig cluster. Reporting interval can be adjusted
by 'dbPersistence.heartBeat.heartbeatInterval' field.

Example:

```json node identification and heartbeat settings
// UniConfig instance naming settings.
"uniconfigInstance": {
    // Identifier of the local UniConfig instance (name must be unique in the cluster). If it is set to 'null'
    // then this identifier is tried to be loaded from 'data/instance_name'. If this file doesn't exist, then
    // name of the UniConfig instance is randomly generated and this file is created with new name of instance.
    "instanceName": null
},
// Heart beat service settings.
"heartBeat": {
    // interval between updating of local UniConfig instance heartbeat timestamp [milliseconds]
    "heartbeatInterval": 1000
}
```

#### Kafka and notification settings

This section contains settings related to connections to Kafka brokers, Kafka publisher timeouts, authentication, 
subscription allocation, and rebalancing settings.

Example with essential settings:

```json notification settings
// Grouped settings that are related to notifications.
"notifications": {
    // Flag that determines whether notifications are collected
    "enabled": true,
    "kafka": {
        // Username used for authentication into Kafka brokers (SASL). If it is not set, then authentication
        // is disabled (PLAINTEXT scheme).
        // "username": "kafka",
        // Password used for authentication into Kafka brokers.
        //"password": "kafka",
        "kafkaServers": [
            {
                // Address / hostname of the interface on which Kafka broker is listening to incoming connections.
                "brokerHost": "kafka-broker",
                // TCP port on which Kafka broker is listening to incoming connections.
                "brokerListeningPort": 9092
            }
        ],
        // Kafka producer settings
        "kafkaProducer": {
            // Specifies the number of messages that the Kafka handler processes as a batch
            "batchSize": 16384
        },
        // Configuration of how long the send() method and the creation of connection for
        // reading of metadata methods will block. (in ms)
        "blockingTimeout": 60000,
        // Configuration of how long will the producer wait for the acknowledgement of a request. (in ms)
        // If the acknowledgement is not received before the timeout elapses, the producer will resend the
        // request or fail the request if retries are exhausted
        "requestTimeout": 30000,
        // Configuration of the upper bound on the time to report success or failure after a
        // call to send() returns.(in ms)
        // This limits the total time that a record will be delayed prior to sending, the time to
        // await acknowledgement from the broker (if expected), and the time allowed for retriable send failures.
        "deliveryTimeout": 120000
    }
    // How often should uniconfig check for unassigned netconf notifications subscriptions (in seconds)
    "netconfSubscriptionsMonitoringInterval": 5,
    // How many unassigned netconf subscriptions can be processed within one subscription monitoring interval
    "maxNetconfSubscriptionsPerInterval": 10,
    // hard limit for how many subscriptions can a single UniConfig node handle
    "maxNetconfSubscriptionsHardLimit": 5000,
    // grace period for a UniConfig node going down. Other nodes will not restart the subscriptions until the grace
    // period passes from when a dead Uniconfig node has been seen last
    "rebalanceOnUCNodeGoingDownGracePeriod": 120,
    // the lower margin to calculate optimal range start
    "optimalNetconfSubscriptionsApproachingMargin": 0.05,
    // the higher margin to calculate optimal range end
    "optimalNetconfSubscriptionsReachedMargin" : 0.10
}
```

### Load-balancer configuration

The following YAML code represents sample Traefik configuration that can be used in the clustered UniConfig deployment
(deployment with 1 Traefik node). There is one registered entry-point with identifier 'uniconfig' and port '8181'.

```yaml traefik configuration
api:
  insecure: true

entryPoints:
  uniconfig:
    address: ":8181"

providers:
  docker: {}
```

Next, it is needed to configure UniConfig docker containers with traefik labels - UniConfig nodes are automatically
detected by Traefik container as 'uniconfig' service providers. There is also URI prefix '/rests', name of the
'sticky cookie' 'uniconfig_server_id' and server port number '8181' (UniConfig web server is listening to incoming
HTTP requests on this port).

```yaml configuration of UniConfig docker container
services:
  uniconfig-1:
    container_name: "uc_1"
    labels:
      - traefik.enable=true
      - traefik.http.routers.uniconfig.entrypoints=uniconfig
      - traefik.http.routers.uniconfig.rule=PathPrefix(`/rests`)
      - traefik.http.services.uniconfig.loadBalancer.sticky.cookie.name=uniconfig_server_id
      - traefik.http.services.uniconfig.loadbalancer.server.port=8181
```

Values of all traefik labels should be same on all nodes in the cluster - scaling of UniConfig service in the cluster
(for example, using Docker Swarm tools) is simple since container settings do not change.

!!!
The similar configuration, like the presented one with Traefik, can be achieved using other load-balancer tools,
such as HAProxy.
!!!

## Clustering of NETCONF subscriptions and notifications

When device is installed with stream property set, subscriptions for all
provided streams are created in database. These subscriptions are always
created with UniConfig instance id set to null, so they can be acquired
by any UniConfig from cluster. Each UniConfig instance in cluster uses
its own monitoring system to acquire free subscriptions. Monitoring
system uses specialized transaction to lock subscriptions which prevents
more UniConfig instances to lock same subscriptions. While locking
subscription, UniConfig instance writes its id to subscription table to
currently locked subscription and which means that this subscription is
already acquired by this UniConfig instance. Other instances of
UniConfig will not find this subscription as free anymore.

### Optimal subscription count and rebalancing

With multiple UniConfig instances working in a cluster, each instance
calculates an optimal range of subscriptions to manage.

```
OPTIMAL_RANGE_LOW = (NUMBER_OF_ALL_SUBSCRIPTIONS / NUMBER_OF_LIVE_UC_NODES_IN_CLUSTER) * OPTIMAL_NETCONF_SUBSCRIPTIONS_APPROACHING_MARGIN
OPTIMAL_RANGE_HIGH = (NUMBER_OF_ALL_SUBSCRIPTIONS / NUMBER_OF_LIVE_UC_NODES_IN_CLUSTER) * OPTIMAL_NETCONF_SUBSCRIPTIONS_REACHED_MARGIN
# Example: optimal range for 5000 subscriptions with 3 nodes in the cluster and margins set to 0.05 and 0.10 = (1750, 1834)
```

Based on optimal range and a number of currently opened subscriptions,
each UniConfig node (while performing a monitoring system iteration)
decides whether it should:

- Acquire additional subscriptions before optimal range is reached
- Stay put and not acquire additional subscriptions in case optimal range is reached
- Release some of its subscriptions to trigger rebalancing until optimal range is reached

When an instance goes down, all of its subscriptions will be immediately
released and the optimal range for the other living nodes will change
and thus the subscriptions will be reopened by the rest of the cluster.

!!!
There is a grace period before the other nodes take over the
subscriptions. So in case a node goes down and up quickly, it will
restart the subscriptions on its own.
!!!

Following example illustrates a timeline of a 3 node cluster and how
many subscriptions each node handles:

![notifications-in-cluster-rebalancing](netconf_subs_rebalancing.svg)

!!!
The hard limit still applies in clustered environment and it will never
be crossed, regardless of the optimal range.
!!!
