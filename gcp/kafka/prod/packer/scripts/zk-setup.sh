#!/bin/bash

sudo yum -y install wget
sudo yum -y install java-11-openjdk

wget https://dlcdn.apache.org/zookeeper/zookeeper-3.9.1/apache-zookeeper-3.9.1-bin.tar.gz
tar -xvzf apache-zookeeper-3.9.1-bin.tar.gz
rm apache-zookeeper-3.9.1-bin.tar.gz

sudo mv apache-zookeeper-3.9.1-bin zookeeper
sudo mv zookeeper /opt

sudo mkdir /var/lib/zookeeper
sudo chown zk:zk /var/lib/zookeeper

sudo mv /home/zk/zoo.cfg /opt/zookeeper/conf/zoo.cfg
sudo chown zk:zk /opt/zookeeper/conf/zoo.cfg

sudo mv /home/zk/bin/zkEnv.sh /opt/zookeeper/bin/zkEnv.sh
sudo chown zk:zk /opt/zookeeper/bin/zkEnv.sh

sudo mv /home/zk/zk.service /etc/systemd/system/zk.service
sudo chown zk:zk /etc/systemd/system/zk.service

echo 'vm.swappiness=1' | sudo tee --append /etc/sysctl.conf

wget https://repo.whatap.io/telegraf/telegraf-release-1.21.1/linux/amd64/telegraf-1.21.1-1.amd64.rpm
sudo yum -y localinstall telegraf-1.21.1-1.amd64.rpm
rm telegraf-1.21.1-1.amd64.rpm
sudo mv /home/zk/telegraf.conf /etc/telegraf/telegraf.conf
sudo mv /home/zk/system.conf /etc/telegraf/telegraf.d/system.conf
sudo mv /home/zk/jolokia.conf /etc/telegraf/telegraf.d/jolokia.conf


wget https://github.com/rhuss/jolokia/releases/download/v1.7.2/jolokia-1.7.2-bin.tar.gz
sudo mkdir /opt/jolokia-1.7.2
sudo chown zk:zk /opt/jolokia-1.7.2
tar -xvf jolokia-1.7.2-bin.tar.gz -C /opt
rm jolokia-1.7.2-bin.tar.gz

echo '
export JOLOKIA="-javaagent:/opt/jolokia-1.7.2/agents/jolokia-jvm.jar=port=7777,host=0.0.0.0"
export SERVER_JVMFLAGS="$SERVER_JVMFLAGS $JOLOKIA"
' >> /opt/zookeeper/bin/zkEnv.sh
