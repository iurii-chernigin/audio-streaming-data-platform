# Instructions for deploying Kafka in Docker

## Before you begin

[Install Docker](https://docs.docker.com/desktop/install/ubuntu/)

When you execute commands below you should be withid the docker-compose.yaml directory

## Run Kafka in Docker

Create network
```
docker create network kafka_network
```
Build Kafka service based on docker-compose.yaml
```
docker-compose build
```
Create & Run a container with Kafka
```
docker-compose up
```
If you want to run a container in the background
```
docker-compose up -d
```

## Topics creation

Follow the instructions: https://kafka.apache.org/quickstart

Download Kafka utils
```bash
mkdir ~/kafka && cd ~/kafka
# Download, the link may be changed for the latest version
wget https://dlcdn.apache.org/kafka/3.4.0/kafka_2.13-3.4.0.tgz
# Unrchive
tar -xzvf kafka_2.13-3.4.0.tgz && rm kafka_2.13-3.4.0.tgz
cd kafka_2.13-3.4.0
```
Topics creation
```bash
# Create topics for events
bin/kafka-topics.sh --bootstrap-server localhost:9092 --create --replication-factor 1 --partitions 1 --topic auth_events
bin/kafka-topics.sh --bootstrap-server localhost:9092 --create --replication-factor 1 --partitions 1 --topic listen_events
bin/kafka-topics.sh --bootstrap-server localhost:9092 --create --replication-factor 1 --partitions 1 --topic page_view_events
```
Useful commands:
```bash
# List of existing topics
bin/kafka-topics.sh --bootstrap-server localhost:9092 --list
# Information about a specified topic
bin/kafka-topics.sh --bootstrap-server localhost:9092 --describe --topic listen_events
# You can check if there are some events in a specific topic
bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --from-beginning --topic listen_events
```

## Clean up

Compose & Run Container with Kafka
```
docker-compose down
```

## Best Practices

- [Kafka GitOps](https://github.com/devshawn/kafka-gitops) is an Apache Kafka resources-as-code tool which allows you to automate the management of your Apache Kafka topics and ACLs from version controlled code.
- [Kafka UI](https://docs.kafka-ui.provectus.io/configuration/quick-start)
