# Store parameters 

| Table    | Description | Optimizations |
| -------- | ------- | ------- |
| listen_events  | Contains infromations about song listents, one event = one song listened    | - Partitioned by ts (event timestamp), ts field use for batch processing on every day scheduling |
| auth_events | Contains information about user aothorizations (log-ins)    | - Partitioned by ts (event timestamp), ts field use for batch processing on every day scheduling |
| page_view_events    | Contains informations about open pages during the user session    | - Partitioned by ts (event timestamp), ts field use for batch processing on every day scheduling |
