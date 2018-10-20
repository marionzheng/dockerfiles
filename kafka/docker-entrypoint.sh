#!/bin/bash

set -e

# override custom config file

if [[ -f "$KAFKA_CONF_DIR/server.properties" ]]; then
    mv -f "$KAFKA_HOME/config/server.properties" "$KAFKA_HOME/config/server.properties.bak"
    cp "$KAFKA_CONF_DIR/server.properties" "$KAFKA_HOME/config/server.properties"
fi

# replace broker & connect configurations

if [[ $KAFKA_BROKER_ID && $KAFKA_BROKER_ID != "-1" ]]; then
    sed -i "s#^broker.id=.*#broker.id=$KAFKA_BROKER_ID#g" $KAFKA_HOME/config/server.properties
fi

if [[ $KAFKA_LOG_DIRS ]]; then
    sed -i "s#^log.dirs=.*#log.dirs=$KAFKA_LOG_DIRS#g" $KAFKA_HOME/config/server.properties
fi

if [[ $KAFKA_HOST_NAME ]]; then
    sed -i "s#^host.name=.*#host.name=$KAFKA_HOST_NAME#g" $KAFKA_HOME/config/server.properties
fi

if [[ $KAFKA_PORT ]]; then
    sed -i "s#^port=.*#port=$KAFKA_PORT#g" $KAFKA_HOME/config/server.properties
fi

if [[ $KAFKA_ADVERTISED_HOST_NAME ]]; then
    sed -i "s#^advertised.host.name=.*#advertised.host.name=$KAFKA_ADVERTISED_HOST_NAME#g" $KAFKA_HOME/config/server.properties
fi

if [[ $KAFKA_ADVERTISED_PORT ]]; then
    sed -i "s#^advertised.port=.*#advertised.port=$KAFKA_ADVERTISED_PORT#g" $KAFKA_HOME/config/server.properties
fi

if [[ $KAFKA_LISTENERS ]]; then
    sed -i "s#^listeners=.*#listeners=$KAFKA_LISTENERS#g" $KAFKA_HOME/config/server.properties
fi

if [[ $KAFKA_ADVERTISED_LISTENERS ]]; then
    sed -i "s#^advertised.listeners=.*#advertised.listeners=$KAFKA_ADVERTISED_LISTENERS#g" $KAFKA_HOME/config/server.properties
fi

if [[ $KAFKA_ZOOKEEPER_CONNECT ]]; then
    sed -i "s#^zookeeper.connect=.*#zookeeper.connect=$KAFKA_ZOOKEEPER_CONNECT#g" $KAFKA_HOME/config/server.properties
fi

exec "$@"