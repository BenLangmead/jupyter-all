#!/bin/sh

set -ex

cont_id=$(docker run --rm -d -p28888:8888 --name jupyter-all -v `pwd`:/home/jovyan/pwd $* benlangmead/jupyter-all)
sleep 2
url=$(docker logs ${cont_id} 2>&1 | tail -n 1 | sed 's/.*8888/http:\/\/127.0.0.1:28888/')
echo ${url}
open ${url}
