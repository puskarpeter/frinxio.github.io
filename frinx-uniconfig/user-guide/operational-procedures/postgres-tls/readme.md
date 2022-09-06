# TLS encryption for Postgres database

By default all the communication to the database is not encrypted.
In deployments where UniConfig is running separately from database, the traffic might be visible to unwanted eyes. Here are the steps to enabling TLS encryption for communication with the database.

## Generating self-signed certificate using OpenSSL

If you already have SSL keys generated, you need to convert them to proper format,
see [Converting SSL keys to proper format](#Converting-SSL-keys-to-proper-format), otherwise you need to generate them.


## Converting SSL keys to proper format

The proper format for the SSL keys is the following:

    Client certificate: PEM encoded X509v3 certificate
    Root certificate: PEM encoded X509v3 certificate
    Key file: PKCS-8 encoded in DER format or PKCS-12 key

The command which needs to be used to convert the keys properly may differ based on the format of the keys in which they are available. They can be converted using OpenSSL version 1.1.1, from command line ```openssl``` command. OpenSSL documentation provides examples for the most common cases. 

To convert to PKCS-8 DER binary format, consult the documentation here: [PKCS-8](https://www.openssl.org/docs/man1.1.1/man1/openssl-pkcs8.html)

To convert to PKCS-12 format, consult the documentation here: [PKCS-12](https://www.openssl.org/docs/man1.1.1/man1/openssl-pkcs12.html)

## Enabling TLS for the database connection

The configuration file that must be modified can
be found on the following path relative to the UniConfig root directory:

```
vim config/lighty-uniconfig-config.json
```

Then edit the **configuration** section in **dbPersistence** section.

Example:

```json
  "connection": {
    "dbName": "uniconfig",
    "username": "uniremote",
    "password": "unipass",
    "initialDbPoolSize": 5,
    "maxDbPoolSize": 20,
    "maxIdleConnections": 5,
    "socketReadTimeout": 20,
    "maxWaitTime": 30000,
    "enabledTls": true,
    "tlsClientCert": "./client.pks",
    "tlsClientKey": "./client.key",
    "tlsCaCert": "./ca.pks",
    "sslPassword": "",
    "databaseLocations": [
      {
        "host": "127.0.0.1",
        "port": 26257
      }
    ],
    "repairSchemaHistory": false
  }
```

The TLS related fields are the following:

`enabledTls` - setting to `true` enables TLS encryption, default is `false`

`tlsClientCert` - specify the **relative** path to the Client certificate from the root UniConfig directory

`tlsClientKey` - specify the **relative** path to the Client key from the root UniConfig directory, this can be PKCS-12 or PKCS-8 format

`tlsCaCert` - specify the **relative** path to the root CA certificate from the root UniConfig directory

`sslPassword` - if the `tlsClientKey` file is encrypted with password, specify it here. It is needed for PKCS-12 keys and for encrypted PKCS-8 keys, this will be ignored for the unencrypted keys.

Do not forget to adjust other database connection parameters accordingly.
