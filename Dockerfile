FROM openjdk:8-jre-slim

ENV DEBIAN_FRONTEND noninteractive
ENV SCALA_VERSION 2.12
ENV KAFKA_VERSION 2.0.0

# Download Kafka
RUN apt-get update && \
    apt-get install -y wget && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean && \
    wget http://mirrors.viethosting.com/apache/kafka/"$KAFKA_VERSION"/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz -O /tmp/kafka.tgz && \
    tar xfz /tmp/kafka.tgz -C /opt && \
    mv /opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION" /opt/kafka && \
    rm /tmp/kafka.tgz

ENV KAFKA_HOME /opt/kafka

COPY run.sh $KAFKA_HOME/run.sh

# 2181 is Zookeeper, 9092 is Kafka
EXPOSE 2181 9092

WORKDIR $KAFKA_HOME
CMD ["/opt/kafka/run.sh"]
