# kafka-single

## Build the docker image
```
docker build -t kafka-single .
```

## Run Kafka
```
docker run -it -p 2181:2181 -p 9092:9092 kafka-single
```
