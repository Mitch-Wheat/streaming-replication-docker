#! /bin/bash

docker rm timescale-primary timescale-replica
docker network rm timescale-replication

docker build -t timescale-primary .
docker build -t timescale-replica .

docker network create timescale-replication

docker run -d --name timescale-primary -p 6000:5432 --network timescale-replication \
--env-file primary.env timescale-primary

docker run -d --name timescale-replica -p 6001:5432 --network timescale-replication \
--env-file replica.env timescale-replica
