# Data Platform for an Audio Streaming service

This data platform is design to solve the following problems:
- Business Intelligence: prepared data will allow analytics to assess the state of the business at various levels. 
- _[plans]_ Proactive actions based on user activity: architechture should allow making offers to users in the app based on real-time data.

# Table of Contents

1. [Architecture Design](#architecture-design)
2. [Data Generation](#data-generation)
3. [Data Ingestion](#data-ingestion)
4. [Data Warehouse](#data-warehouse)
5. [Data Visualization (BI)](#bi)

## Architecture Design

![plot](./architechture.png)

Requirements & SLA: 
- Data must be in a centralized repository; 
- Events should be written to the storage with a delay of no more than one minute;
- Data model must reflect business processes;
- Data must be clean and reliable;
- Data must be accessible 24/7;
- Data must be documented.

## Data Generation 

The project is based on events generated by https://github.com/viirya/eventsim. This events reflect user behaviour in a fake music web site (like Spotify).
<br/>Launch instructions are here: [data-generation/readme](https://github.com/iurii-chernigin/audio-streaming-data-platform/tree/main/data-generation#readme)

## Data Ingestion

### Kafka Deployment

Kafka is used to store events before they are sent to the data warehouse.

There are two options:
- Deploy Kafka with Google Kubernetes Engine and Terraform: [infrastructure/terraform](https://github.com/iurii-chernigin/audio-streaming-data-platform/tree/main/infrastructure/terraform#readme)
- Deploy Kafka locally in Docker: [infrastructure/kafka](https://github.com/iurii-chernigin/audio-streaming-data-platform/tree/main/infrastructure/kafka#readme)

\#terraform \#kubernetes \#docker \#kafka 

### Kafka Consumers

Custom Java consumers are used to consume and send events from Kafka topics to Data Warehouse tables.

Link to Java application implementation: [audio-streaming-java-consumer](https://github.com/iurii-chernigin/audio-streaming-java-consumer/tree/main#readme)

\#java \#kafka-consumers

## Data Warehouse

Data Warehouse is built on BigQuery: [audio-streaming-data-platform/data-warehouse](https://github.com/iurii-chernigin/audio-streaming-data-platform/tree/main/data-warehouse#readme)

There are three main data layers:
- Raw - raw data ingested from Kafka;
- Core - cleaned and normalized data according to Data Vault 2.0;
- Data Marts - wide tables that are easy to analyze and create reports & dashboards. This is the main entry point into the data for data analysts & scientists.

To transform the data, dbt with the dbtvault library is used: [audio-streaming-dbt-datavault](https://github.com/iurii-chernigin/audio-streaming-dbt-datavault)

\#bigquery \#dbt \#dbtvault \#data-vault

## BI

Looker is used to create reports & dashboards. The dashboard in the picture below is available at the link: https://lookerstudio.google.com/s/iWa4oRy9nc4

![plot](./looker-dashboard.png)

\#looker

### Usefull links

- dbt: [models orchestration with Prefect](https://prefecthq.github.io/prefect-dbt/)
- Terraform: [deploy applications with the Helm provider](https://developer.hashicorp.com/terraform/tutorials/kubernetes/helm-provider)

## Plans

- Try workflow orchestration tool: https://flyte.org/
