## Monitoring using Metrics

Uniconfig exposes multiple metrics to monitor the traffic and other useful values to monitor its performance.
Output can be in form of plaintext log messages in the log file **metrics.log** in the **log** directory in the **root** of the distribution
or in the form of raw data in CSV format from which it can be further processed by the 3rd party visualization tools.
CSV files are located in the **metrics** directory in the **root** of the distribution.

## Types of metrics
- Gauge - reports instantanious value at a point in time (for example queue size)
- Meter - measures total count of event occurences, total mean rate, mean rates for past 1, 5 and 15 minutes time windows 

## List of notable metrics exposed by Uniconfig

- **Gauges**
    - io.frinx.uniconfig.manager.impl.task.TaskExecutorImpl.queue_size - The number of tasks in the queue waiting for execution
    - org.apache.sshd.server.SshServer.active_sessions - The number of active CLI sessions
    - org.opendaylight.controller.uniconfig.transaction.manager.api.UniconfigTransactionManager.open_transaction_count - The number of open transactions
- **Meters**
    - org.opendaylight.yangtools.yang.common.RpcResult.rpc_invoke - All the invoked RPCs by Uniconfig
    - org.opendaylight.controller.uniconfig.transaction.manager.impl.UniconfigTransactionManagerImpl.transaction_invoke - All the invoked transactions in Uniconfig
    - io.frinx.uniconfig.shell.cli.SshTerminal.cli_message - All the invoked commands in Uniconfig CLI shell

## Configuration

Configuration is done via a section in "uniconfig-lighty-config.json" file:

```json
"metrics": {
            // flag that determines if metrics will be reported or not
            "enabled": true,
            // reporter type (log, csv)
            "reporter": "log",
            // reporting rate in seconds
            "rate": 30
    }
```

## Example output

- metrics/org.opendaylight.controller.uniconfig.transaction.manager.impl.UniconfigTransactionManagerImpl.transaction_invoke.csv

```csv
t,count,mean_rate,m1_rate,m5_rate,m15_rate,rate_unit
1650557436,3,0.182204,0.507889,0.580330,0.593370,events/second
1650557466,3,0.064564,0.308050,0.525104,0.573917,events/second
1650557496,3,0.039233,0.186842,0.475134,0.555102,events/second
1650557526,3,0.028178,0.113325,0.429919,0.536904,events/second
1650557534,3,0.026281,0.104264,0.422813,0.533929,events/second
1650557927,3,0.015632,0.027484,0.323844,0.488517,events/second
1650612500,3,0.055825,0.283420,0.516425,0.570738,events/second
```

- log/metrics.log

```log
09:27:12.007 INFO io.frinx.uniconfig.metrics.impl.ReporterImpl - Starting SFL4J reporter
09:27:42.018 INFO io.frinx.uniconfig.metrics.impl.ReporterImpl - type=GAUGE, name=io.frinx.uniconfig.manager.impl.task.TaskExecutorImpl.queue_size, value=0
09:27:42.025 INFO io.frinx.uniconfig.metrics.impl.ReporterImpl - type=METER, name=org.opendaylight.controller.uniconfig.transaction.manager.impl.UniconfigTransactionManagerImpl.transaction_invoke, count=0, m1_rate=0.0, m5_rate=0.0, m15_rate=0.0, mean_rate=0.0, rate_unit=events/second
09:27:42.026 INFO io.frinx.uniconfig.metrics.impl.ReporterImpl - type=METER, name=org.opendaylight.yangtools.yang.common.RpcResult.rpc_invoke, count=3, m1_rate=0.5078890349343685, m5_rate=0.5803296602892035, m15_rate=0.5933702335763534, mean_rate=0.19861560202310877, rate_unit=events/second
09:28:12.026 INFO io.frinx.uniconfig.metrics.impl.ReporterImpl - type=GAUGE, name=io.frinx.uniconfig.manager.impl.task.TaskExecutorImpl.queue_size, value=0
09:28:12.026 INFO io.frinx.uniconfig.metrics.impl.ReporterImpl - type=METER, name=org.opendaylight.controller.uniconfig.transaction.manager.impl.UniconfigTransactionManagerImpl.transaction_invoke, count=0, m1_rate=0.0, m5_rate=0.0, m15_rate=0.0, mean_rate=0.0, rate_unit=events/second
09:28:12.027 INFO io.frinx.uniconfig.metrics.impl.ReporterImpl - type=METER, name=org.opendaylight.yangtools.yang.common.RpcResult.rpc_invoke, count=3, m1_rate=0.3080502714195554, m5_rate=0.5251039914257685, m15_rate=0.5739172434618175, mean_rate=0.06651106239706056, rate_unit=events/second
09:28:20.659 INFO io.frinx.uniconfig.metrics.impl.ReporterImpl - type=GAUGE, name=io.frinx.uniconfig.manager.impl.task.TaskExecutorImpl.queue_size, value=0
09:28:20.659 INFO io.frinx.uniconfig.metrics.impl.ReporterImpl - type=METER, name=org.opendaylight.controller.uniconfig.transaction.manager.impl.UniconfigTransactionManagerImpl.transaction_invoke, count=0, m1_rate=0.0, m5_rate=0.0, m15_rate=0.0, mean_rate=0.0, rate_unit=events/second
09:28:20.659 INFO io.frinx.uniconfig.metrics.impl.ReporterImpl - type=METER, name=org.opendaylight.yangtools.yang.common.RpcResult.rpc_invoke, count=3, m1_rate=0.28341993164460894, m5_rate=0.5164247858550347, m15_rate=0.5707376547004283, mean_rate=0.05582675920800621, rate_unit=events/second
```