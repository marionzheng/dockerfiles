#!/bin/bash

set -e

if [ $LOG_HOME ]; then
    mkdir -p $LOG_HOME/supervisor $LOG_HOME/python
fi

exec "$@"