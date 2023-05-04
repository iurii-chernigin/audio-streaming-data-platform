# Raw Tables Specification

This section describes data in the raw layer only, all other views & tables are generetated by dbt models.

| Table    | Description | Optimizations |
| -------- | ------- | ------- |
| listen_events  | Contains infromations about song listents, one event = one song listened    | - Partitioned by ts (event timestamp), ts field use for batch processing on every day scheduling |
| auth_events | Contains information about user aothorizations (log-ins)    | - Partitioned by ts (event timestamp), ts field use for batch processing on every day scheduling |
| page_view_events    | Contains informations about open pages during the user session    | - Partitioned by ts (event timestamp), ts field use for batch processing on every day scheduling |
| status_change_events    | Contains informations about user account level changes    | - Partitioned by ts (event timestamp), ts field use for batch processing on every day scheduling |
