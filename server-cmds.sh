#!/usr/bin/env bash

echo "inside shell cmds"
echo "variables $1 $2"

if[-e docker ps -q --filter ancestor=$2]
then
echo "inside if function"
docker stop $(docker ps -q --filter ancestor=$2)
fi

docker run -p 3080:3080 -d $1