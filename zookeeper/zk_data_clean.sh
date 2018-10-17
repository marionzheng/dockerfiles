#!/bin/bash

count=60
count=$[$count+1]
ls -t $ZOO_DATA_LOG_DIR/log.* | tail -n +$count | xargs rm -f
ls -t $ZOO_DATA_DIR/snapshot.* | tail -n +$count | xargs rm -f