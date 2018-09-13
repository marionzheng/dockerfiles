#!/bin/bash

set -e

if [ -f "$KAFKA_CONF_DIR/server.properties" ]; then
    mv -f "$KAFKA_HOME/config/server.properties" "$KAFKA_HOME/config/server.properties.bak"
    cp "$KAFKA_CONF_DIR/server.properties" "$KAFKA_HOME/config/server.properties"
fi

sed -i "s/broker.id=0/broker.id=$KAFKA_BROKER_ID/g" $KAFKA_HOME/config/server.properties
sed -i "s/host.name=localhost/host.name=$KAFKA_HOST_NAME/g" $KAFKA_HOME/config/server.properties
sed -i "s#listeners=PLAINTEXT://localhost:9092#listeners=PLAINTEXT://$KAFKA_HOST_NAME:9092#g" $KAFKA_HOME/config/server.properties
sed -i "s#advertised.listeners=PLAINTEXT://localhost:9092#advertised.listeners=PLAINTEXT://$KAFKA_HOST_NAME:9092#g" $KAFKA_HOME/config/server.properties
sed -i "s:log.dirs=/tmp/kafka-logs:log.dirs=$KAFKA_DATA_DIR:g" $KAFKA_HOME/config/server.properties
sed -i "s/zookeeper.connect=localhost:2181/zookeeper.connect=$ZOO_CONNECT/g" $KAFKA_HOME/config/server.properties

exec "$@"