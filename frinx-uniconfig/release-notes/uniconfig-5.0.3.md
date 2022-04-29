---
order: 11
---

# UniConfig 5.0.3

## :white_check_mark: New Features

### Adding failed transactions into transaction log

**Description**

Previously, only successfully committed transactions have been written into transaction log.

Added state to transaction log entry that determines, if transaction has been successfully or not committed - both successful and failed 
transactions are part of transaction log.

**Documentation**

[!ref text="Transaction Log | Frinx Docs"](../user-guide/uniconfig-operations/transaction-log/)

**API**

Added ‘status' leaf and split ‘commit-time’ into ‘last-commit-time’ and 'failed-commit-time’ (YANG module transaction-log):

```
  container transactions-metadata {
    config false;
    description "Container for list of transactions metadata.";

    list transaction-metadata {
      key "transaction-id";
      ordered-by user;
      description "List of transactions metadata.";

      leaf transaction-id {
        description "Transaction identifier.";
        type types:uuid;
      }
      choice type-of-commit-time {
        mandatory true;
        case last-commit-time-case {
          leaf last-commit-time {
            description "Date and time of the last commit.";
            type types:date-and-time;
          }
        }
        case failed-commit-time-case {
          leaf failed-commit-time {
            description "Date and time of when the transaction failed.";
            type types:date-and-time;
          }
        }
      }

      leaf status {
        type enumeration {
          enum "success";
          enum "failed";
        }
      }

      list metadata {
        key "node-id";
        description "List of changes.";

        min-elements 1;
        uses transaction-entry;
      }
    }
  }
```

## :bulb: Improvements

### Integrated OWASP dependency check tool into UniConfig

- 3-rd party libraries are check against security issues during building of UniConfig distribution. If there are some issues with security level higher than configured threshold, built will fail.
- Set security threshold level to 10 and fixed corresponding critical errors.

## :x: Bug Fixes

### Fixed updating of leaf-list content (ordered/unordered) on NETCONF device 

- Unordered leaf-list must be updated using following steps:
    
    1. removing all items that are not in the updated list
    2. inserting all items that are only in the updated list

---

- There was 1 bug: step 1. never happened.

- Ordered leaf-list must be updated using following steps:
    1. inserting/moving new/existing items in the correct order (using ordering parameters) [1]
    2. removal of all items that are not in the updated list [2]

---

- There was 1 bug  - all items were removed and afterwards re-inserted without usage of special positional attributes - it created conflict on NETCONF layer between edits and thus splitting of NETCONF traffic into 2 edit-config messages.

### Device discovery /32 prefix changed to inclusive

User must be able to ping network with prefix /32 - it must be rendered as single host (special case).

### UniConfig shell - exit - it is expected to hit enter twice

**Previous behaviour:**

```
$ ssh -p 2022 admin@127.0.0.1
Password authentication
Password: 
uniconfig>exit
^
I press <ENTER> but the program is waiting for hitting the next <ENTER> button

Connection to 127.0.0.1 closed by remote host.
Connection to 127.0.0.1 closed.
```

After fix, UniConfig will print user some message, that one more <ENTER> is expected to leave SSH session.
  