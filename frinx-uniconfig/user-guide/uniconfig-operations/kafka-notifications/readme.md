# Kafka Notifications

## Introduction

NETCONF devices are able to produce NETCONF notifications.
UniConfig can collect these notifications and create its own
UniConfig notifications about specific events. Kafka is used to publish
these notifications from NETCONF devices and UniConfig.

The following notification types are available:

- NETCONF notifications
- Notifications about transactions
- Audit logs (RESTCONF notifications)
- Data-change events
- Connection notifications

Each notification type is stored in its own topic in Kafka. Additionally,
all notifications are stored in one table in the database.

![notifications-in-cluster](cluster.svg)

## Kafka

Apache Kafka is a publish–subscribe-based, durable messaging system
that sends messages between processes, applications and servers.
Within Kafka, you can define topics (think categories) and applications
can add, process and reprocess records.

In our specific case, UniConfig is publishes notifications. Each type
of notification is stored in a separate topic and therefore can be
subscribed to independently. The names of topics and connection data are
configurable in the *lighty-uniconfig-config.json* file.

## NETCONF notifications

[RFC 5277](https://tools.ietf.org/html/rfc5277) defines a
mechanism where the NETCONF client indicates an interest in receiving event
notifications from a NETCONF server by subscribing to
receive event notifications. The NETCONF server replies
whether the subscription request was successful and, if it was
successful, starts sending event notifications to the NETCONF client
as events occur within the system. These event notifications are
sent until either the NETCONF session or the subscription is terminated.

NETCONF notifications are categorised as so-called streams. The subscriber
must choose which streams to receive. The default stream is named *NETCONF*.

## Notifications about transactions

This type of notification is generated after each commit in UniConfig.
It contains the following:

- transaction id
- calculate diff result
- commit result

## Audit logs (RESTCONF notifications)

This type of notification is generated after each RESTCONF operation.

**It contains:**

- transaction id
- request data
    - uri
    - http-method
    - source-address
    - source-port
    - query-parameters
    - user-id
    - body
- response data
    - status-code
    - query-parameters
    - body

The response body does not need to be included in notifications. It can be
configured using the *includeResponseBody* parameter in
the *application.properties* file. Also, the calculation difference result can be part
of the notification if the *includeCalculateDiffResult* parameter is set to *true* 
in the *application.properties* file.

There are three examples of notifications with the response body and the calculation
difference result.

The first example is for created data:

```json
{
  "eventTime": "2023-02-09T10:00:59.39924-00:00",
  "nodeId": "UC-25be4cb4-2426-493c-97d9-ba16a735d810",
  "streamName": "RESTCONF",
  "identifier": "audit-log",
  "body": {
    "request": {
      "host": {
        "source-port": 48094,
        "source-address": "127.0.0.1"
      },
      "body": "{\n    \"network\": [\n        {\n            \"name\": \"BB1\",\n            \"interfaces\": [\n                \"vni-0/3.72\"\n            ]\n        }\n    ]\n}",
      "uri-data": {
        "uri": "http://127.0.0.1:8181/rests/data/network-topology:network-topology/topology=uniconfig/node=vnf20/configuration/networks/network=BB1",
        "http-method": "PUT"
      }
    },
    "transaction-id": "e0956588-bb94-46a3-a0e0-adecca318dfe",
    "response": {
      "status-code": 201
    },
    "calc-diff": {
      "createdData": {
        "path": "network-topology:network-topology/topology=uniconfig/node=vnf20/frinx-uniconfig-topology:configuration/native-schemas-vnf20-network:networks/network=BB1",
        "data": {
          "network": [
            {
              "name": "BB1",
              "interfaces": [
                "vni-0/3.72"
              ]
            }
          ]
        }
      }
    }
  }
}
```

The second example is for deleted data:

```json
{
  "eventTime": "2023-02-09T10:00:48.62214-00:00",
  "nodeId": "UC-25be4cb4-2426-493c-97d9-ba16a735d810",
  "streamName": "RESTCONF",
  "identifier": "audit-log",
  "body": {
    "request": {
      "host": {
        "source-port": 48094,
        "source-address": "127.0.0.1"
      },
      "body": "{\n    \"network\": [\n        {\n            \"name\": \"BB1\",\n            \"interfaces\": [\n                \"vni-0/3.72\"\n            ]\n        }\n    ]\n}",
      "uri-data": {
        "uri": "http://127.0.0.1:8181/rests/data/network-topology:network-topology/topology=uniconfig/node=vnf20/configuration/networks/network=BB1",
        "http-method": "DELETE"
      }
    },
    "transaction-id": "e0956588-bb94-46a3-a0e0-adecca318dfe",
    "response": {
      "status-code": 204
    },
    "calc-diff": {
      "deletedData": {
        "path": "network-topology:network-topology/topology=uniconfig/node=vnf20/frinx-uniconfig-topology:configuration/native-schemas-vnf20-network:networks/network=BB1",
        "data": {
          "network": [
            {
              "name": "BB1",
              "interfaces": [
                "vni-0/3.72"
              ]
            }
          ]
        }
      }
    }
  }
}
```

The third example is for updated data:

```json
{
  "eventTime": "2023-02-09T10:00:37.40739-00:00",
  "nodeId": "UC-25be4cb4-2426-493c-97d9-ba16a735d810",
  "streamName": "RESTCONF",
  "identifier": "audit-log",
  "body": {
    "request": {
      "host": {
        "source-port": 48094,
        "source-address": "127.0.0.1"
      },
      "body": "{\n    \"network\": [\n        {\n            \"name\": \"BB1\",\n            \"interfaces\": [\n                \"vni-0/3.72\"\n            ]\n        }\n    ]\n}",
      "uri-data": {
        "uri": "http://127.0.0.1:8181/rests/data/network-topology:network-topology/topology=uniconfig/node=vnf20/configuration/networks/network=BB1",
        "http-method": "PUT"
      }
    },
    "transaction-id": "e0956588-bb94-46a3-a0e0-adecca318dfe",
    "response": {
      "status-code": 204
    },
    "calc-diff": {
      "updatedData": {
        "path": "network-topology:network-topology/topology=uniconfig/node=vnf20/frinx-uniconfig-topology:configuration/native-schemas-vnf20-network:networks/network=BB1",
        "dataBefore": {
          "native-schemas-vnf20-network:interfaces": [
            "vni-0/3.1"
          ]
        },
        "dataAfter": {
          "native-schemas-vnf20-network:interfaces": [
            "vni-0/3.72"
          ]
        }
      }
    }
  }
}
```

## Shell notifications

This type of notification is generated after each shell operation.

**It contains:**

- transaction id
- request data
    - source-address
    - source-port
    - prompt
    - executed command
- response data
    - output

```json
{
  "eventTime": "2022-08-08 17:45:26.62239+00",
  "nodeId": "UC-5b4d0cec-6493-4e3d-bd1c-348a3ce83600",
  "streamName": "SHELL",
  "identifier": "shell-notification",
  "body": {
    "request": {
      "host": {
        "source-port": 2022,
        "source-address": "127.0.0.1"
      },
      "prompt": "show-netconf>",
      "executed-command": "abcd interfaces abc abc-1"
    },
    "response": {
      "output": "{  \"name\": \"abc-1\",  \"enable\": true}"
    },
    "transaction-id": "2d090dc4-9ee9-4a14-abb9-506a7ff1d414"
  }
}
```

## Data-change events

User must perform subscription step before data-change-events are generated and published into Kafka.
Using subscription, user specifies observed subtrees against data-changes. Afterwards, data-change-events
are generated by UniConfig instances after some transaction is committed and committed changes contain
subscribed subtrees.

Sample data-change-event captured by Kafka console consumer:

```json
{
  "eventTime": "2022-02-14T07:36:39.55857-00:00",
  "nodeId": "UC-f057f8fa-8024-499a-94e9-904ce37fca78",
  "streamName": "DCE",
  "identifier": "data-change-event",
  "body": {
    "subscription-id": "f2a786a6-eea3-419c-8341-750d388181a0",
    "transaction-id": "634ac8c3-c20b-4d83-a283-a31fe0bed1a6",
    "edit": [
      {
        "subtree-path": "/process=p3",
        "data-after": "{\n  \"process\": [\n    {\n      \"uid\": \"p3\"\n    }\n  ]\n}",
        "operation": "CREATE",
        "node-id": "node"
      },
      {
        "subtree-path": "/process=p2",
        "data-before": "{\n  \"process\": [\n    {\n      \"uid\": \"p2\"\n    }\n  ]\n}",
        "operation": "DELETE",
        "node-id": "node"
      },
      {
        "subtree-path": "/process=p1/address/bus-size",
        "data-after": "{\n  \"config:bus-size\": 2048\n}",
        "data-before": "{\n  \"config:bus-size\": 1024\n}",
        "operation": "UPDATE",
        "node-id": "node"
      },
      {
        "subtree-path": "/process=p1/address/bus-id",
        "data-after": "{\n  \"config:bus-id\": \"0xFFFF\"\n}",
        "data-before": "{\n  \"config:bus-id\": \"0x451FE\"\n}",
        "operation": "UPDATE",
        "node-id": "node"
      }
    ]
  }
}
```

In case of data-change-events, streamName is always 'DCE' and identifier of YANG notification is 'data-change-event'.
Body contains:

- subscription-id: Identifier of the subscription that triggers generation of data-change-event.
  Subscription identifier makes association of subscriptions and received data-changes-events easier than using
  combination of multiple fields such as node identifier, topology identifier and subtree path.
- transaction-id: Identifier of committed transaction that triggered data-change-event after commit or checked-commit
  UniConfig operations.
- edit - List of captured modifications done in the committed transaction.

Edit entry fields:

- subtree-path: Relative path to data-tree element at which data-change happened. Path is relative to subtree-path
  specified during subscription.
- data-before: JSON representation of subtree data before done changes. If this field is not present, then 'data-after'
  represents created data.
- data-after: JSON representation of subtree data including done changes. If this fields is not present, then
  'data-before' represents removed data.
- operation: Operation type of the data change event.
- node-id: Node identifier of the data change event.

## Connection notifications

Connection notification are generated whenever status of some node changes.
For connection notifications, streamName is always 'CONNECTION' and identifier of YANG notification is '
connection-notification'.

It contains:

- topology id
- node id
- connection status
- connection message

Supported topologies are cli, netconf and gnmi.

Sample connection notifications captured by Kafka console consumer:

**CLI disconnect notification:**

```json
{
  "eventTime": "2022-02-17T10:09:28.76615-00:00",
  "nodeId": "UC-5b4d0cec-6493-4e3d-bd1c-348a3ce83600",
  "streamName": "CONNECTION",
  "identifier": "connection-notification",
  "body": {
    "connection-status": "disconnected",
    "node-id": "R1",
    "connection-message": "",
    "topology": "cli"
  }
}
```

**NETCONF connect notification:**

```json
{
  "eventTime": "2022-02-17T10:09:51.41777-00:00",
  "nodeId": "UC-5b4d0cec-6493-4e3d-bd1c-348a3ce83600",
  "streamName": "CONNECTION",
  "identifier": "connection-notification",
  "body": {
    "connection-status": "connecting",
    "node-id": "R2",
    "connection-message": "Connecting",
    "topology": "topology-netconf"
  }
}
```

## Database entities

There are three tables related to notifications in database:

- notification
- settings
- netconf-subscription

Notifications are stored in notification table. It has these columns:

- stream name - name of the notification stream - NETCONF stream name or UniConfig-specific stream name
- node id - node id of the NETCONF device for NETCONF notifications or identifier of UniConfig instance in case of other
  types of notifications
- identifier - name of the YANG notification
- body - full notification body in JSON format
- event time - time when notification was generated

Example request for reading notifications using RESTCONF:

```bash Request
curl --location --request GET 'http://localhost:8181/rests/data/notifications:notification' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json'
``` 

Settings table has 2 columns: identifier and config. Record with
identifier kafka contains configuration for kafka that can be modified
at runtime.

Example request for reading kafka settings using RESTCONF:

```bash Request
curl --location --request GET 'http://localhost:8181/rests/data/kafka-brokers:kafka-settings' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json'
``` 

NETCONF subscription table is used to track NETCONF notification
subscriptions. It has the following columns:

- node id - id of the NETCONF node from which notifications should be collected
- UniConfig instance id - instance id of UniConfig that is collecting notifications from the NETCONF device
- stream name - NETCONF stream name
- creation time - time when subscription was created
- start time - time when notifications start to be collected
- end time - time when notifications stop to be collected

Example request for reading subscriptions using RESTCONF:

```bash Request
curl --location --request GET 'http://localhost:8181/rests/data/netconf-subscriptions:netconf-subscriptions' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json'
```

## NETCONF subscriptions

To receive NETCONF notifications from NETCONF device it is necessary to
create subscription. Subscription is created using install request:

```bash Request
curl --location --request POST 'http://localhost:8181/rests/operations/connection-manager:install-node' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--data-raw '{
    "input":{
        "node-id":"versa_2",
        "netconf":{
            "netconf-node-topology:host":"10.103.5.202",
            "netconf-node-topology:port":2022,
            "netconf-node-topology:session-timers": {
                "netconf-node-topology:keepalive-delay": 5,
                "netconf-node-topology:max-connection-attempts":1,
                "netconf-node-topology:initial-connection-timeout":60,
                "netconf-node-topology:request-transaction-timeout":60,
                "netconf-node-topology:reconnection-attempts-multiplier":1.0
            },
            "netconf-node-topology:other-parameters": {
                "netconf-node-topology:edit-config-test-option":"set"
            },
            "netconf-node-topology:tcp-only":false,
            "netconf-node-topology:username":"admin",
            "netconf-node-topology:password":"versa123",
            "uniconfig-config:UniConfig-native-enabled":true,
            "uniconfig-config:blacklist":{
                "extension":[
                    "tailf:display-when false"
                ]
            },
            "stream":[
                {
                    "stream-name":"NETCONF",
                    "start-time":"2021-11-08T02:00:00+00:00",
                    "stop-time":"2021-11-08T22:00:00+00:00"
                },
                {
                    "stream-name":"oam"
                }
            ]
        }
    }
}'
``` 

Subscriptions to notification streams are defined as list with name
*stream*. There is one record for each stream. The only required
parameter is *stream-name*. Besides the required *stream-name*
parameter, this record also supports optional parameters:

- *start-time* - must be specified if user wants to enable replay and
  it should start at the time specified.
- *stop time* - used with the optional replay feature to indicate the
  newest notifications of interest. If stopTime is not specified,
  notifications will continue until the subscription is terminated.
  Must be used with and set to be later than *start-time*. Values in the
  future are valid.

!!!
Creation of new subscription for the stream will terminate all
existing subscriptions for this stream.
!!!

## Monitoring system - processing NETCONF subscriptions

Inside UniConfig, NETCONF notification subscriptions are processed in an
infinite loop within the monitoring system. An iteration of the monitoring
system loop consists of following steps:

1. Check global setting for NETCONF notifications
    - If turned off, release all NETCONF subscriptions and end current iteration

2. Release cancelled subscriptions

3. Query free subscriptions from DB, and for each one:
    1. Create a notification session (create mountpoint and register listeners)
    2. Lock the subscription (set UniConfig instance)

!!!
There is a hard limit for how many sessions can a single UniConfig node
handle. In case this limit is reached, UniConfig node refuses to acquire
additional subscriptions.
!!!

Loop interval, hard subscription limit and maximum number of
subscriptions processed per interval can be set in
lighty-uniconfig-config.json file.

### Dedicated NETCONF session for subscription

NETCONF device may have the :interleave capability that indicates
support to interleave other NETCONF operations within a notification
subscription. This means the NETCONF server can receive, process and
respond to NETCONF requests on a session with an active notification
subscription. However, not all devices support this capability, so the
common approach for devices \'with\' and \'without\' interleave
capability is to track notifications with a separate NETCONF session. In
order to support this functionality, UniConfig will create a separate
NETCONF session with a separate mount-point for every subscription.
These mount points and sessions are destroyed automatically when the
corresponding subscription is closed.

![monitoring-system](monitoring.svg)

## Subscription to data-change events

### Creating a new subscription

Subscription to data-change-events can be created using 'create-data-change-subscription' RPC. After subscription
is done, UniConfig starts to listen to data-change-events on selected nodes and subtrees and distribute corresponding
messages to dedicated Kafka topic.

RPC input contains:

- node-id: Identifier for the node from which data-change-events are generated. This field is optional. If not given,
  a global subscription is created and data-change-events are generated for all nodes under the topology.
- topology-id: Identifier of topology where specified node is placed.
- subtree-path: Path to the subtree from which the user would like to receive data-change-events. Default path is '/'
- captured data-change-events from whole node configuration.
- data-change-scope: Data-tree scope that specified how granular data-change-events should be captured and propagated
  to Kafka. There are 3 options ('SUBTREE' is default value):
    - 'SUBTREE': Represents a change of the node or any of its child nodes, direct and nested.
      This scope is a superset of ONE and BASE.
    - 'ONE': Represent a change (addition, replacement, or deletion) of the node on the subtree-path or one of its
      direct child elements.
    - 'BASE': Represents only a direct change of the node on subtree-path, such as replacement of a node,
      addition or deletion.

RPC output contains only generated 'subscription-id' in format of UUID. This subscription identifier represents token
that can be used by user:

- displaying information about created subscription using RPC
- deleting existing subscription
- sorting received Kafka messages

Example: creation of subscription to node 'device1' from 'uniconfig' topology and to whole configuration
subtree '/interfaces'.

```bash RPC Request
curl --location --request POST 'http://127.0.0.1:8181/rests/operations/data-change-events:create-data-change-subscription' \
--header 'Content-Type: application/json' \
--data-raw '{
    "input": {
        "node-id": "device1",
        "topology-id": "uniconfig",
        "subtree-path": "/interfaces",
        "data-change-scope": "SUBTREE"
    }
}'
```

```json RPC response
{
  "output": {
    "subscription-id": "8e82453d-4ea8-4c26-a74e-50d855a721fa"
  }
}
```

Example: Creating a subscription to the *uniconfig* topology and to the whole */interfaces* configuration
subtree.

```bash RPC Request
curl --location --request POST 'http://127.0.0.1:8181/rests/operations/data-change-events:create-data-change-subscription' \
--header 'Content-Type: application/json' \
--data-raw '{
    "input": {
        "topology-id": "uniconfig",
        "subtree-path": "/interfaces",
        "data-change-scope": "SUBTREE"
    }
}'
```

```json RPC response
{
  "output": {
    "subscription-id": "1920770c-671d-4d2e-8126-6309ab73ff10"
  }
}
```

### Removing a subscription

Existing subscription can be removed using 'delete-data-change-subscription' RPC and provided subscription-id.
After subscription is removed, UniConfig stops generation of new data-change-events related to subscribed path.

RPC input contains only 'subscription-id' - unique identifier of subscription to data-change-events. RPC output
doesn't contain body. RPC will return 404, if subscription with provided identifier doesn't exist.

Example: removal of subscription with ID '8e82453d-4ea8-4c26-a74e-50d855a721fa':

```bash RPC Request
curl --location --request POST 'http://127.0.0.1:8181/rests/operations/data-change-events:delete-data-change-subscription' \
--header 'Content-Type: application/json' \
--data-raw '{
  "input": {
    "subscription-id": "8e82453d-4ea8-4c26-a74e-50d855a721fa"
  }
}'
```

### Showing information about subscription

The RPC 'show-subscription-data' can be used for displaying information about created subscription. RPC input contains
identifier of target subscription.

RPC output for existing subscription contains 'topology-id', 'node-id', 'subtree-path' and 'data-change-scope' - the
same fields that can also be specified in the 'create-data-change-subscription' RPC input.
If subscription with specified ID doesn't exist, RPC will return 404 status code with standard RESTCONF error container.

Example: showing information about

```bash RPC Request
curl --location --request POST 'http://127.0.0.1:8181/rests/operations/data-change-events:show-subscription-data' \
--header 'Content-Type: application/json' \
--data-raw '{
  "input": {
    "subscription-id": "8e82453d-4ea8-4c26-a74e-50d855a721fa"
  }
}
```

```json RPC response
{
    "output": {
        "subtree-path": "/interfaces",
        "topology-id": "uniconfig",
        "data-change-scope": "SUBTREE",
        "node-id": "device1"
    }
}
```

It is also possible to fetch all created subscriptions under a specific node or topology by sending a GET request
to the 'data-change-subscriptions' list under the 'node' list item (operational data).

Example (there are 2 subscriptions under 'device1' node):

```bash GET request
curl --location --request GET 'http://127.0.0.1:8181/rests/data/network-topology:network-topology/topology=uniconfig/node=device1/data-change-subscriptions?content=nonconfig' \
--header 'Accept: application/json'
```

```json GET response
{
    "data-change-events:data-change-subscriptions": [
        {
            "subscription-id": "8e82453d-4ea8-4c26-a74e-50d855a721fa",
            "subtree-path": "/interfaces",
            "data-change-scope": "SUBTREE"
        },
        {
            "subscription-id": "3b3ad917-f1a1-4cc4-83b9-3c8b62929b81",
            "subtree-path": "/ospf",
            "data-change-scope": "ONE"
        }
    ]
}
```

```bash GET request
curl --location --request GET 'http://127.0.0.1:8181/rests/data/network-topology:network-topology/topology=uniconfig/data-change-subscriptions?content=nonconfig' \
--header 'Accept: application/json'
```

```json GET response
{
    "data-change-events:data-change-subscriptions": [
        {
            "subscription-id": "4058acac-1a2a-4c49-abe9-bcdbd14fe933",
            "subtree-path": "/events:event",
            "data-change-scope": "SUBTREE"
        },
        {
            "subscription-id": "a2561773-c02e-403c-a090-fe6542926fed",
            "subtree-path": "/events:event",
            "data-change-scope": "BASE"
        }
    ]
}
```

## Configuration

Configuration for notifications is in lighty-uniconfig-config.json file
under *notifications* property. Whole configuration looks like this:

```json
{
  "notifications": {
    "enabled": true,
    "kafka": {
      "username": "kafka",
      "password": "kafka",
      "kafkaServers": [
        {
          "brokerHost": "127.0.0.1",
          "brokerListeningPort": 9092
        }
      ],
      "netconfNotificationsEnabled": true,
      "auditLogsEnabled": true,
      "transactionNotificationsEnabled": true,
      "dataChangeEventsEnabled": true,
      "netconfNotificationsTopicName": "netconf-notifications",
      "auditLogsTopicName": "auditLogs",
      "transactionsTopicName": "transactions",
      "dataChangeEventsTopicName": "data-change-events",
      "blockingTimeout": 60000,
      "requestTimeout": 30000,
      "deliveryTimeout": 120000,
      "maxThreadPoolSize": 8,
      "queueCapacity": 2048,
      "embeddedKafka": {
        "enabled": true,
        "installDir": "/tmp/embedded-kafka",
        "archiveUrl": "https://dlcdn.apache.org/kafka/3.0.0/kafka_2.12-3.0.0.tgz",
        "dataDir": "./data/embedded-kafka",
        "cleanDataBeforeStart": true,
        "partitions": 1
      }
    },
    "auditLogs": {
      "includeResponseBody": true
    },
    "notificationDbTreshold": {
      "maxCount": 10000,
      "maxAge": 100
    },
    "netconfSubscriptionsMonitoringInterval": 5,
    "maxNetconfSubscriptionsPerInterval": 10,
    "maxNetconfSubscriptionsHardLimit": 5000,
    "rebalanceOnUCNodeGoingDownGracePeriod": 120,
    "optimalNetconfSubscriptionsApproachingMargin": 0.05,
    "optimalNetconfSubscriptionsReachedMargin": 0.10
  }
}
```

All notifications and the monitoring system can be enabled or disabled
with the *enabled* flag.

**Three (3) properties related to the monitoring system:**

- subscriptionsMonitoringInterval - How often the monitoring system
  loop is run and attempts to acquire free subscriptions. The value is
  given in seconds, the default value is 5.
- maxSubscriptionsPerInterval - The maximum number of free subscriptions
  that can be acquired in a single iteration of the monitoring system
  loop. If the number of free subscriptions is smaller than this value,
  all free subscriptions are processed. If the number of free subscriptions
  is larger than this value, only the specified number of subscriptions are
  acquired. The rest can be acquired during the next iterations of the
  monitoring system loop or by other UniConfing instances in the cluster.
  The default value is 10.
- maxNetconfSubscriptionsHardLimit - Maximum number of subscriptions that 
  a single UniConfig node can handle.

**Three (3) properties related to the monitoring system in clustered
environments:**

- rebalanceOnUCNodeGoingDownGracePeriod - Grace period for a
  UniConfig node going down. Other nodes will not restart
  subscriptions until the grace period has passed after a dead
  Uniconfig node was last seen. The default value is 120 seconds.
- optimalNetconfSubscriptionsApproachingMargin - The lower margin to
  calculate optimal range start. The default value is 0.05.
- optimalNetconfSubscriptionsReachedMargin - The higher margin to
  calculate optimal range end. The default value is 0.10.

**Three (3) properties related to the timeout of messages to Kafka**

- blockingTimeout - How long the **send()** method and the creation of
  a connection for reading metadata methods will block (in ms).
- requestTimeout - How long the producer waits for acknowledgement of a
  request (in ms). If no acknowledgement is received before the timeout
  period is over, the producer will resend the request or, if retries are
  exhausted, fail it.
- deliveryTimeout - The upper bound on the time to report success or failure
  after a call to **send()** returns (in ms). Sets a limit on the total time
  that a record will be delayed prior to sending, the time to wait for
  acknowledgement from the broker (if expected) and the time allowed for
  retriable send failures.

**Two (2) properties related to the thread pool executor required to
send messages to Kafka**

- maxThreadPoolSize - The maximum thread pool size in the executor.
- queueCapacity - The maximum capacity for the work queue in the executor.

**Two (2) properties used to limit the number of records in the notifications table in the database:**

- maxCount - Maximum number of records in the notifications table. If the
  number of records exceeds this value, the oldest record in the table is
  deleted. The default value is 10,000.
- maxAge - Maximum age of a record in the notifications table (in hours).
  Records older than this value are deleted. The default value is 100.

These properties are under *notificationDbTreshold*. Both of these are
implemented using database triggers. Triggers are running on inserts to
notifications table.

Audit logs settings are under auditLogs property. Currently there is
only one flag *includeResponseBody* that is used to enable or disable of
logging body of RESTCONF responses.

All settings related to kafka are grouped under *kafka* property. For
authentication there are *username* and *password* properties. For kafka
connection there is *kafkaServers* property. This contains list of kafka
servers as combination of *brokerHost* and *brokerListeningPort*. Broker
host can be either ip address or hostname.

It is possible to enable/disable each type of notifications
independently. To do that these flags are used:

- netconfNotificationsEnabled
- auditLogsEnabled
- transactionNotificationsEnabled
- dataChangeEventsEnabled

It is possible to setup names of all topics for every notification type.
This is done using:

- transactionsTopicName - topic name for transactions about notifications
- netconfNotificationsTopicName - topic name for NETCONF notifications
- auditLogsTopicName - topic name for audit logs
- dataChangeEventsTopicName - topic name for data-change-events

It is also possible to setup embedded kafka. These setting are grouped
under *embeddedKafka* property:

- enabled - flag that enables or disables embedded kafka
- installDir - where should be kafka files placed
- archiveUrl - where to download kafka from
- dataDir - kafka data directory
- cleanDataBeforeStart - if kafka config should be cleared before start

Kafka settings are also stored in db. This way they can be changed at
runtime. This change can be done using RESTCONF or UniConfig shell.
Kafka setting are stored in settings table.

## Kafka client - example

To read notifications from kafka, it is possible to use command line
consumer. It is done by running following command in kafka installation
directory:

```bash
bin/kafka-console-consumer.sh \
 --bootstrap-server localhost:9092 \
 --topic netconf-notifications
```

It is important to have properly setup hostname, port and topic name.
Output after creation of NETCONF notification may look like this:

```json
{
  "eventTime": "2021-12-03T08:16:45.75600-00:00",
  "nodeId": "R1",
  "streamName": "NETCONF",
  "identifier": "netconf-session-start",
  "body": {
    "session-id": 191,
    "source-host": "10.255.246.85",
    "username": "admin"
  }
}
```
