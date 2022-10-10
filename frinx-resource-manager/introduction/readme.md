---
order: 5
---

# FRINX Resource Manager introduction

FRINX Resource Manager was developed for network operators and infrastructure
engineers to manage their physical and logical assets and resources.
Examples for assets are locations, equipment, ports and services.
Examples for resources are IP addresses, VLAN IDs and other consumables
required for operating data services. Resource Manager was developed
specifically to address the needs of network and infrastructure
engineers working with communication networks. FRINX Resource Manager
provides GUI and a GraphQL based API to create, read, update and delete
assets. Resource Manager can be deployed standalone or as part of FRINX
Machine.

## Features

Following list contains features inherent to Resource Manager.

### Resource type management

Resource type is a blueprint for how to represent a resource instance. A
resource type is essentially a set of property types, where each
property type defines:

- Name: name of the property
- Type: int, string, float etc.

Example resource types:

- **VLAN**
    - Property type
        - Name: vlan
        - Type: int
- **Route distinguisher**
    - Property type
        - Name: RD
        - Type: String
- **Location**
    - Property type
        - Name: Latitude
        - Type: float
    - Property type
        - Name: Longitude
        - Type: float

Resource Manager is flexible enough to enable user defined resource types
without requiring code compilation or any other non-runtime task. With
regard to resource types, this requires keeping the schema flexible
enough so that users can define their own types and properties and thus
create their own model.

### Resource management

A resource is an instance of a resource type consisting of a number of
properties.

Example resources based on resource types from previous section:

- **VLAN\_1**
    - Property
        - Name: vlan
        - Value: 44
- **Route distinguisher\_1**
    - Property
        - Name: RD
        - Value: 0:64222:100:172.16.1.0
- **Location\_1**
    - Property
        - Name: Latitude
        - Value: 0.0
    - Property
        - Name: Longitude
        - Value: 0.0

![Resource types](Resource_Manager_resource_types.png)

### Flexible design

One of the main non-functional goals of the Resource Manager is flexibility.
We are designing Resource Manager to support an array of use cases without the
need for modifications. To achieve flexibility we are allowing:

- Custom resource type definition without changes in the DB schema
- Custom allocation logic without the need to modify the backend code
- Custom pool grouping to represent logical network parts (subnet,
    region, datacenter etc.)

### Multitenancy and RBAC

Multitenancy and Role Based Access Control is supported by Resource Manager.

A simple RBAC model is implemented where only super-users (based on
their role and user groups) can manipulate resource types, resource
pools and labels. Regular users will only be able to read the above
entities, allocate and free resources.

Resource Manager does not manage list tenants/users/roles/groups and relies
on external ID provider. Following headers are expected by Resource Manager
graphQL server:

```
    x-tenant-id:        name or ID of a tenant. This name is also used as part of PSQL DB instance name.
    from:               name or ID of current user.
    x-auth-user-roles:  list of roles associated with current user.
    x-auth-user-groups: list of groups associated with current user.
```

Resource Manager does not store any information about users or tenants in the
database, **except the name or ID of a tenant provided in `x-tenant-id`
header**.
