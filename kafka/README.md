# There will be instructions how to run docker container properly


## Run Kafka in Docker

Docker network creation
```bash
docker network  create kafka-spark-network
```

Compose & Run Container with Kafka
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
```

## Best Practices

- [Kafka GitOps](https://github.com/devshawn/kafka-gitops) is an Apache Kafka resources-as-code tool which allows you to automate the management of your Apache Kafka topics and ACLs from version controlled code.
- [Kafka UI](https://docs.kafka-ui.provectus.io/configuration/quick-start)