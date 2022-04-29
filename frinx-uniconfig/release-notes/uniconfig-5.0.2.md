---
order: 10
---

# UniConfig 5.0.2

## :white_check_mark: New Features

### Upgrading templates

**Description**

- Implemented RPC for upgrading template to specific YANG repository.
- RPC input:
    - template name (mandatory)
    - output template name (optional, default value = input template name)
    - YANG repository name (optional, default value = latest YANG repository)
- RPC output:
    - without body, just status message
    - if it fails, we will return standard RESTCONF RFC-8040 error container
- Implemented automation of the upgrading process - calling of this RPC automatically at initialisation of UniConfig for all templates present in the DB that don’t use the latest repository.

**Documentation**

[!ref text="Templates Manager| Frinx Docs"](../user-guide/uniconfig-operations/templates-manager/#upgrading-template-to-latest-yang-repository)

**API**

Added ‘upgrade-template' RPC into 'template-manager’ YANG module:

```
rpc upgrade-template {
    description "RPC used for upgrading/migrating template to another version of YANG repository.";

    input {
        leaf template-name {
            type string;
            mandatory true;
            description "Identifier of the template.";
        }
        leaf upgraded-template-name {
            type string;
            description "Identifier of the upgraded template. Default value is input 'template-name'.";
        }
        leaf yang-repository {
            type string;
            description "Name of yang-repository used for upgrading of templates.
                         It contains identifier of the YANG schema repository.
                         Default value is latest configured YANG repository.";
        }
    }
}
```

**Configuration**

Supplemented template configuration by 2 new settings (lighty-uniconfig-config.json) - `enabledTemplatesUpgrading` and `maxBackupTemplateAge`.

```
// Template settings
"templates": {
    // Enabled templates - if it is set to 'false', UniConfig will not prepare YANG modules for templates
    // - creation of templates will not work. Enabled templates consumes more memory than setup without templates.
    "enabled": true
    /* Name of the YANG module which is used for comparison of loaded YANG repositories based on revision and
       further saving the name of the latest YANG repository. Latest YANG repository is automatically used
       at creation of new template node, if user doesn't specify it explicitly. If this setting is not specified,
       this feature will be disabled.*/
    // "latestSchemaReferenceModuleName": "system"
    // Enabled auto-upgrading of templates that are using old YANG repository to templates with same name
    // and latest YANG repositories (applying version-drop). Before templates are upgraded, they are also backed up.
    "enabledTemplatesUpgrading": false,
    // Maximum age of backup template [days]. After that age, template will be removed from database permanently.
    // Negative value will cause removing of such template immediately at the next UniConfig booting process.
    "maxBackupTemplateAge": -1
}
```

Both settings are related to auto-upgrading process - they don’t influence execution of RPC which can be still done manually.

### Connection notifications

**Description**

- Connection notifications are generated after state of southbound CLI/NETCONF/GNMI node is updated - either status message or connection status.
- Notifications are published into dedicated Kafka topic.
- They are useful especially for debugging connection issues between UniConfig and network devices.

**Documentation**

[!ref text="Kafka Notifications | Frinx Docs"](../user-guide/uniconfig-operations/kafka-notifications/#connection-notifications)

**API**

Structure of notifications are described following YANG module 'connection-notifications':

```
module connection-notifications {
  yang-version 1.1;
  namespace "http://frinx.io/connection/notifications";
  prefix cn;


  revision 2022-02-09 {
    description "Initial revision";
  }

  notification connection-notification {
    description "Notification generated when status of node changes.";

    leaf topology {
      type string;
      mandatory true;
      description "Topology under which node is mounted.";
    }

    leaf node-id {
      type string;
      mandatory true;
      description "Identifier of the node that was connected/disconnected.";
    }

    leaf connection-status {
      type string;
      mandatory true;
      description "Short connection status of the node.";
    }

    leaf connection-message {
      type string;
      mandatory true;
      description "Additional connection info. It may contain failure reason.";
    }
  }
}
```

Added settings used for configuration of Kafka topic and enabled/disabled state (YANG module kafka-brokers):

```
grouping kafka-global-settings {
    ...
    leaf connection-notifications-topic {
        type string;
        mandatory true;
        default "connection-notifications";
        description "Identifier of the Kafka topic used for distribution of connect and disconnect notifications.";
    }
    ...
    leaf connection-notifications-enabled {
        type boolean;
        mandatory true;
        default "true";
        description "If connection notifications are enabled.";
    }
}
```

**Configuration**

Supplemented corresponding settings into in the lighty-uniconfig-config.json file (by default, these notifications are enabled if globally notification system is enabled):

```
// Grouped settings that are related to notifications.
"notifications": {
        // Identifier of topic for connection notifications
        "connection-notifications-topic": "connection-notifications,
        // Enabled collection and propagation of connection-notifications into Kafka.
        "connection-notifications-enabled": true
}
```

### Configurable transaction idle-timeout

**Description**

- Introduced new transaction parameter that can be used at creation of new transaction and overrides global idle-timeout.
- After inactivity of the transaction, it is automatically closed and an exception will be thrown if user tries to invoke some operation on the transaction.

**Documentation**

[!ref text="Example request with timeout parameter | Frinx Docs"](../user-guide/uniconfig-operations/build-and-commit-model/#example-request-with-timeout-parameter)

**API**

Format of the query parameter 'timeout':

```
http://localhost:8181/rests/operations/uniconfig-manager:create-transaction?timeout=100
```

**Uniconfig-client**

Introduced `TransactionParameters` class - object of this class can be provided at creation of new transaction. By default, transaction-specific idle-timeout is disabled - global idle-timeout is used.

```
/*
 * Copyright © 2022 Frinx and others.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package io.frinx.uniconfig.client.tx.params;

public final class TransactionParameters {
    private final IdleTimeout idleTimeout;

    private TransactionParameters(IdleTimeout idleTimeout) {
        this.idleTimeout = idleTimeout;
    }

    /**
     * Get idle timeout.
     *
     * @return {@link IdleTimeout}
     */
    public IdleTimeout getIdleTimeout() {
        return idleTimeout;
    }

    public static final class TransactionParametersBuilder {

        /**
         * Default value specifies that per transaction idle timeout is disabled and global value will be used instead.
         */
        public static final IdleTimeout DEFAULT_IDLE_TIMEOUT = IdleTimeout.DEFAULT;

        private IdleTimeout idleTimeout = DEFAULT_IDLE_TIMEOUT;

        /**
         * Creation of empty builder.
         */
        public TransactionParametersBuilder() {
        }

        /**
         * Set idle timeout.
         *
         * @param idleTimeout {@link IdleTimeout}
         * @return updated builder
         */
        public TransactionParametersBuilder setIdleTimeout(IdleTimeout idleTimeout) {
            this.idleTimeout = idleTimeout;
            return this;
        }

        /**
         * Building a new {@link TransactionParameters} instance.
         *
         * @return built {@link TransactionParameters}
         */
        public TransactionParameters build() {
            return new TransactionParameters(idleTimeout);
        }
    }
}
```

### Added option to disable validation phase at commit

**Description**

- UniConfig uses 3-phase commit procedure - validation, confirmed-commit, confirming-commit. Validation is currently always executed on nodes that support validation and have been installed with enabled validation.
- This feature introduces flag in the commit RPC using which user can control execution of validation phase.

**Documentation**

[!ref text="RPC commit | Frinx Docs"](../user-guide/uniconfig-operations/uniconfig-node-manager/rpc_commit/#rpc-commit)

**API**

Added 'do-validate' field into commit RPC input (checked-commit does not supported this feature for now):

```
grouping commit-input-fields {
  uses target-nodes-fields;
  uses rollback-input-fields;

  leaf do-validate {
    description "Option to enable/disable validation at commit. Default value is true - validate";
    type boolean;
    default true;
  }
}
```

**Uniconfig-client**

- In the uniconfig-client validation is 'disabled' by default (opposite behaviour in comparison to RESTCONF API).
- Exposed new method in DOMReadWriteTx interface:

```
/**
 * Commit Uniconfig transaction - sending modifications to network devices and application of modifications
 * into CONFIGURATION datastore. If commit successfully finishes, then this transaction will also be closed.
 *
 * @param doValidate False = skip validation, True = perform validation
 * @return commit RPC output
 */
JSONObject commit(boolean doValidate);
```

### Modification of connection parameters after the first installation without uninstallation

**Description**

- After some CLI/NETCONF device has already been installed, it is possible to update some connection / mount parameters (for example, ‘host' or 'password’).
- User can read and update connection parameters under ‘cli' or 'topology-netconf’ topology, under specific network-topology nodes.
- Afterwards, UniConfig will use updated connection parameters at the next creation of connection to device. 
- NETCONF sessions used for receiving of NETCONF notifications are also updated at the next monitoring iteration.

**Documentation**

[!ref text="Updating installation parameters | Frinx Docs"](../user-guide/network-management-protocols/updating-installation-parameters/#updating-installation-parameters)

**Uniconfig-client**

Example:

```
/*
 * Copyright © 2022 Frinx and others.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package io.frinx.samples;

import io.frinx.uniconfig.client.device.DeviceMountBuilder;
import io.frinx.uniconfig.client.device.NetconfDeviceMount;
import io.frinx.uniconfig.client.device.NetconfDeviceMount.Protocol;
import io.frinx.uniconfig.client.services.NetconfDeviceService;
import io.frinx.uniconfig.client.services.Uniconfig;
import io.frinx.uniconfig.client.services.config.UniconfigServerSettings.UniconfigServerSettingsBuilder;
import java.util.Collections;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public final class UpdateMountPointSettingsUseCase {

    private static final Logger LOG = LoggerFactory.getLogger(UpdateMountPointSettingsUseCase.class);

    private static final String DEVICE_ID = "dev01";
    private static final String NOTIFICATION_NODE_ID = "dev01_NETCONF";
    private static final NetconfDeviceMount NETCONF_DEVICE_MOUNT = new DeviceMountBuilder()
            .setProtocol(Protocol.SSH)
            .setHost("10.103.5.202")
            .setPort(2022)
            .setUsername("admin")
            .setPassword("dev01")
            .setUseNativeModels(true)
            .setExtensionsToIgnore(Collections.singletonList("tailf:display-when false"))
            .createDeviceMount();

    private UpdateMountPointSettingsUseCase() {
        throw new UnsupportedOperationException("Sample class");
    }

    public static void main(String[] args) throws InterruptedException {
        // preparation of uniconfig services
        final var settings = new UniconfigServerSettingsBuilder()
                .setUniconfigHostname("127.0.0.1")
                .setRestServerPort(8181)
                .setUsername("admin")
                .setPassword("admin")
                .build();
        final Uniconfig uniconfig = Uniconfig.create(settings);
        final NetconfDeviceService netconfDeviceService = uniconfig.netconf(DEVICE_ID);

        // install device
        if (!netconfDeviceService.isInstalled()) {
            LOG.info("Installing device {}", DEVICE_ID);
            netconfDeviceService.installDevice(NETCONF_DEVICE_MOUNT);
        }

        final var nodeHostBefore = readMountPointHost(uniconfig, DEVICE_ID);
        final var notificationNodeHostBefore = readMountPointHost(uniconfig, NOTIFICATION_NODE_ID);

        // update device settings
        final var deviceMountBuilder = netconfDeviceService.createDeviceMountBuilder()
                .setHost("10.103.5.203");
        final NetconfDeviceMount newSettings = deviceMountBuilder.createDeviceMount();
        netconfDeviceService.updateMountPointSettings(newSettings);

        Thread.sleep(10000);

        final var nodeHostAfter = readMountPointHost(uniconfig, DEVICE_ID);
        final var notificationNodeHostAfter = readMountPointHost(uniconfig, NOTIFICATION_NODE_ID);


        LOG.info("Mount point host before: " + nodeHostBefore);
        LOG.info("Mount point host after: " + nodeHostAfter);
        LOG.info("Notification mount point host before: " + notificationNodeHostBefore);
        LOG.info("Notification mount point host after: " + notificationNodeHostAfter);

        // uninstall device from UniConfig
        netconfDeviceService.uninstallDevice();
    }

    private static String readMountPointHost(final Uniconfig uniconfig, final String nodeId) {
        return uniconfig.rest().get("network-topology:network-topology/topology=topology-netconf/node="
                + nodeId + "/netconf-node-topology:host")
                .map(o -> o.get("netconf-node-topology:host").toString())
                .orElse(null);
    }
}
```

## :bulb: Improvements

### Improved aggregation of NETCONF messages

- Non-overlapping edit-config messages are already aggregated into one edit-config message that is sent to NETCONF server. However, this aggregation was primitive - it just serialised all modified subtrees and stacked them under root element without considering option, that paths to these subtrees may overlap.
- After this improvement, edit-config message will contain compressed subtree structures without duplicated ‘wrapper’ elements.

### Added session-id to NETCONF logs (netconf-messages)

**Description**

- Previously, only internal Netty’s channel-id was displayed in the logs.
- After this improvement, NETCONF-specific session-id, returned from device during exchanging of capabilities, will be used.

**Documentation**

[!ref text="Logging Framework | Frinx Docs"](../user-guide/operational-procedures/logging/#netconf-messages) 

**Making connection-manager unit tests more robust**

Preventing random failures because of multi-threaded environment.

**Improve error message if device/template doesn't exist**

- If device/template or another node doesn’t exist, UniConfig should return user-friendly error message that corresponding node doesn’t exist and not some YANG-related error.
- Creation of new node with specified YANG repository is still allowed.

**Error message before the fix:**

```
Could not parse path 'network-topology:network-topology/topology=templates/node=Controller-2/configuration/ntp'. Offset: '88': Node with name 'ntp' is present multiple times under '(http://frinx.openconfig.net/yang/uniconfig-topology?revision=2017-11-21)configuration' in different namespaces. Please, specify child node with the module name in the [module-name]:[element-name] format. Candidate children nodes: [native-schema-940295645-ntp:ntp, native-schema-889970179-template-ntp:ntp, native-latest-template-ntp:ntp, native-schema-889970179-ntp:ntp, native-test-template-ntp:ntp, native-schema-940295645-template-ntp:ntp, native-test-ntp:ntp, native-latest-ntp:ntp]\n"
```

**Error message after the fix:**

```
Template with name 'Controller-2' doesn't exist
```

## :x: Bug Fixes

### Fixed YANG packager that does not catch broken submodules

**Description**

- Fixed reporting of two kinds of issues related to YANG submodules:

1. Submodules contain statement “belongs-to” some parent. That parent should contain statement “include”. When parent does not contain this statement, uniconfig marks submodule as broken.
2. When submodule contains “belongs-to” statement, but parent does not exists.

- Improved error message output from YANG packager utility.

**Documentation**

[!ref text="Device Discovery | Frinx Docs"](../user-guide/uniconfig-operations/device-discovery/#device-discovery)

### Fixed device-discovery behaviour for network with /31 prefix

**Description**

Use cases:

- 192.168.1.0/32 - returns empty output, there aren’t any usable hosts that can be reached
- 192.168.1.0/31 - special case, device-discovery component should verify two hosts - .1 and .2
- 192.168.1.0/30 - returns 192.168.1.1, 192.168.1.2

**Documentation**

[!ref text="Device Discovery | Frinx Docs"](../user-guide/uniconfig-operations/device-discovery/#device-discovery)

### Fixed calculate-diff operation (augmentation nodes)

Augmentation nodes have been skipped and unwrapped during reading of data from device. It resulted  in the failed / incorrect calculation of diff on UniConfig layer.

After this fix, UniConfig skips only those augmentation nodes that contain only non-config data nodes (YANG 'config false' statement).
