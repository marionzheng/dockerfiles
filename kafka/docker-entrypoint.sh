#!/bin/bash

set -e

sed -i "s/broker.id=0/broker.id=$BROKER_ID/g" $KAFKA_CONF_DIR/server.properties
sed -i "s/zookeeper.connect=localhost:2181/zookeeper.connect=$ZK_CONNECT/g" $KAFKA_CONF_DIR/server.properties

exec "$@"