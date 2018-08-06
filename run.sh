#!/bin/bash

export KAFKA_HOST=$(hostname -i)

function updateConfig() {
    key=$1
    value=$2
    file=$3

    # Omit $value here, in case there is sensitive information
    echo "[Configuring] '$key' in '$file'"

    # If config exists in file, replace it. Otherwise, append to file.
    if grep -E -q "^#?$key=" "$file"; then
        sed -r -i "s@^#?$key=.*@$key=$value@g" "$file" #note that no config values may contain an '@' char
    else
        echo "$key=$value" >> "$file"
    fi
}

updateConfig "listeners" "PLAINTEXT://$KAFKA_HOST:9092" config/server.properties

# Start to run zookeeper as background process
bin/zookeeper-server-start.sh config/zookeeper.properties &

# Start kafka server
bin/kafka-server-start.sh config/server.properties
