#!/usr/bin/env bash

echo "inside shell cmds"
echo "variables $1 $2"
if(docker ps -q --filter ancestor=$2){
docker stop $(docker ps -q --filter ancestor=$2)
}
docker run -p 3080:3080 -d $1