## Operational data about transactions

To have a better overview of UniConfig transactions, 
there are operational data about all open transactions.

**Data about transactions contain:**

- identifier (uuid)
- creation time
- last access time
- idle timeout
- hard timeout
- list of changed nodes (incl. topologies)
- additional context (random string, text column)

Data about transactions can be read using RESTCONF:

```bash Request
curl --location --request GET 'http://localhost:8181/rests/data/transaction-data:transactions-data' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json'
```

Example data about transactions:

```json
{
  "transactions-data": {
    "transaction-data": [
      {
        "transaction-id": "af668e97-a947-4dc5-9db5-f3e239bf6a1a",
        "idle-timeout": 300,
        "additional-context": "uc client",
        "last-access-time": "2022-Apr-13 07:25:29.876 +0000",
        "hard-timeout": 600,
        "creation-time": "2022-Apr-13 07:25:29.792 +0000"
      },
      {
        "transaction-id": "e3721366-8f97-4777-b4bd-d164012af79e",
        "idle-timeout": 2,
        "additional-context": "RESTCONF",
        "last-access-time": "2022-Apr-13 07:25:58.269 +0000",
        "hard-timeout": 600,
        "creation-time": "2022-Apr-13 07:25:52.607 +0000"
      }
    ]
  }
}
```