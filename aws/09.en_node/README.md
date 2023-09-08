# Operating Private Archive EN Node

## 1. Create EC2 Instance

First, you need to create an EC2 instance using Terraform.
Modify the VPC ID, Subnet ID, Security Group ID, etc., to match your environment.
You will need one instance each for Baobab and Cypress, for a total of 2 instances.

---

## 2. Install EN Node

[Refer to Klaytn Official Documentation](https://docs.klaytn.foundation/content/installation-guide/deployment/endpoint-node/installation-guide)

1. Go to the latest release page from [Download Klaytn EN Node](https://docs.klaytn.foundation/content/installation-guide/deployment/download).

2. Install the EN Node package ([Guide](https://docs.klaytn.foundation/content/installation-guide/deployment/endpoint-node/installation-guide/installation-guide)).

3. Check the installation

```

sudo service kend status

```

---

## 3. Configure EN Node

[Refer to Klaytn Official Documentation](https://docs.klaytn.foundation/content/installation-guide/deployment/endpoint-node/installation-guide/configuration)

- Copy the `kend.conf` file from the `private_archive_en_cypress` folder to create the `/etc/kend/kend.conf` file.
- Modify the `ENV_KAFKA_BROKER_HOST` value to the appropriate value. (Bootstrap broker host of the previously created MSK)
- Configure the directory to put data
  - `DATA_DIR=/data/baobab`
  - `DATA_DIR=/data/cypress`
- —npt.disabled true (https://medium.com/klaytn/klaytn-v1-10-0-release-notes-4d9320224ae#:~:text=add%20the%20%2D%2D-,ntp.disable,-flag%20in%20your)
- `mkdir -p /data/baobab` &nbsp;OR&nbsp; `mkdir -p /data/cypress`

- In the EN Node settings, you can configure the `chaindatafetcher` to send topic data to MSK.

```

--chaindatafetcher \
--chaindatafetcher.kafka.brokers $KAFKA_BROKER_1 \
--chaindatafetcher.kafka.brokers $KAFKA_BROKER_2 \
--chaindatafetcher.mode kafka \
--chaindatafetcher.kafka.topic.environment $KAFKA_TOPIC_ENV \
--chaindatafetcher.kafka.required.acks -1 \
--chaindatafetcher.kafka.partitions $KAFKA_PARTITION_NUM \
--chaindatafetcher.kafka.replicas $KAFKA_REPLICATION_FACTOR \
--chaindatafetcher.kafka.max.message.bytes 52428800 \
--chaindatafetcher.num.handlers 20 \
--vm.internaltx \

```

- [EN Node Flags](https://github.com/klaytn/klaytn/blob/d8c3b98ef3f899d6d941c03b717b8be26e20127f/cmd/utils/flags.go)

- [Topic Name Creation Rules](https://github.com/klaytn/klaytn/blob/e743a2c1b81031da95bee3a7a06a658ae2686e07/datasync/chaindatafetcher/kafka/config.go#L111)

---

## 4. Fast Sync

[Refer to Klaytn Official Documentation](https://docs.klaytn.foundation/content/installation-guide/deployment/endpoint-node/installation-guide/configuration#fast-sync-optional)

- Perform a fast sync to synchronize up to recent data quickly.
- Download the compressed file and extract it to the location specified in `DATA_DIR` set above.
- Be sure to fully extract the compressed file before proceeding to the next step.

---

## 5. Start EN Node

You can start or stop the endpoint node using the following commands:

> **start**

```

kend start

```

> **stop**

```

kend stop

```

> **status**

```

kend status

```

---

## 6. Check If the EN Node Sends Topic Data to Kafka

### a. Connect to the Zookeeper Instance (Kafka)

```

zkCli.sh -server ZOOKEEPER_HOST:2181

```

### b. Check the topic list

```

ls /brokers/topics

```

The topics are as follows:

- **_cypress.klaytn.chaindatafetcher.en-0.blockgroup.v1_**: Topic for storing block data created by `Cypress EN Node`.
- **_cypress.klaytn.chaindatafetcher.en-0.tracegroup.v1_**: Topic for storing Internal Transaction data created by `Cypress EN Node`.
- **_baobab.klaytn.chaindatafetcher.en-0.blockgroup.v1_**: Topic for storing block data created by `Baobab EN Node`.
- **_baobab.klaytn.chaindatafetcher.en-0.tracegroup.v1_**: Topic for storing Internal Transaction data created by `Baobab EN Node`.

If these topics are created, you can confirm that the EN Node is sending data to Kafka.
