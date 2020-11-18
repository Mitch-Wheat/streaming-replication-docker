#! /bin/bash

docker rm timescale-primary timescale-replica timescale-replica2
docker network rm timescale-replication

docker build -t timescale-primary .
docker build -t timescale-replica .
docker build -t timescale-replica2 .

docker network create timescale-replication

docker run -d --name timescale-primary -p 6000:5432 --network timescale-replication \
--env-file primary.env timescale-primary

docker run -d --name timescale-replica -p 6001:5432 --network timescale-replication \
--env-file replica.env timescale-replica

docker run -d --name timescale-replica2 -p 6002:5432 --network timescale-replication \
--env-file replica2.env timescale-replica2
