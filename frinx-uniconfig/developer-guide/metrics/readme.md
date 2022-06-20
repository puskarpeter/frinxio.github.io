# Metrics

## Monitoring Uniconfig performance

[Dropwizard Metrics](https://metrics.dropwizard.io/) is the framework of choice to monitor performance.

## Registry naming

All the metrics are currently stored in the *uniconfig* registry.
It can be accessed like so:
```java
import com.codahale.metrics.SharedMetricRegistries;

SharedMetricRegistries.getOrCreate("uniconfig");
```

## Metric types

All the available metric types can be seen in the [documentation](https://metrics.dropwizard.io/4.2.0/manual/core.html).

## Naming convention

There are various best practice articles on how to name metrics but one thing is common: It should be clear what is measured.

```java
MetricRegistry.name(TaskExecutorImpl.class, "queue_size");
```

## Adding new metrics

### Adding a Meter

Obtain a Meter and then mark all the method calls you want to measure.

```java
private final Meter rpcMeter = SharedMetricRegistries.getOrCreate("uniconfig")
            .meter(MetricRegistry.name(RpcResult.class, "rpc_invoke"));

private void foo() {
    rpcMeter.mark();
}
```

### Adding a Gauge

For Gauge method **getValue()** needs to be implemented.
It can be done less verbously with lambda expressions so that we avoid writing boilerplate code for an anonymous class:

```java
private final Gauge<Integer> openTransactionsCount = SharedMetricRegistries.getOrCreate("uniconfig").gauge(
            MetricRegistry.name(UniconfigTransactionManager.class, "open_transaction_count"), () -> () -> {
                synchronized (UniconfigTransactionManagerImpl.this) {
                    return UniconfigTransactionManagerImpl.this.uniconfigTransactions.size();
                }
            }
    );
```

Here we create a **Gauge** that returns Integer value, access is synchronized in this case to avoid race conditions.

## Tags 

Tags are currently not available in the version *4.2.x*, although support for them is planned for future major release.

## Reporters 

Current available reporters are reports to CSV files and reporting via Slf4j to log file.