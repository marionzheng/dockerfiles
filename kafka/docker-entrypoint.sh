#!/bin/bash

set -e

sed -i "s/broker.id=0/broker.id=$KAFKA_BROKER_ID/g" $KAFKA_CONF_DIR/server.properties
sed -i "s/host.name=localhost/host.name=$KAFKA_HOST_NAME/g" $KAFKA_CONF_DIR/server.properties
sed -i "s/log.dirs=\/tmp\/kafka-logs/log.dirs=$KAFKA_DATA_DIR/g" $KAFKA_CONF_DIR/server.properties
sed -i "s/zookeeper.connect=localhost:2181/zookeeper.connect=$ZOO_CONNECT/g" $KAFKA_CONF_DIR/server.properties

exec "$@"