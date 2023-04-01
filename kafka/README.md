# There will be instructions how to run docker container properly

## Kafka Utils

Follow the instructions: https://kafka.apache.org/quickstart

```bash
# Download
wget https://dlcdn.apache.org/kafka/3.4.0/kafka_2.13-3.4.0.tgz
# Unrchive
tar -xzvf kafka_2.13-3.4.0.tgz
```

## Run Kafka in Docker

Docker network creation
```bash
docker network  create kafka-spark-network
```

Compose & Run Container with Kafka
```
docker-compose up -d
```

## Best Practices

- [Kafka GitOps](https://github.com/devshawn/kafka-gitops) is an Apache Kafka resources-as-code tool which allows you to automate the management of your Apache Kafka topics and ACLs from version controlled code.
- [Kafka UI](https://docs.kafka-ui.provectus.io/configuration/quick-start)