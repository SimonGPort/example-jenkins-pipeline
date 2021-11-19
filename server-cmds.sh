#!/usr/bin/env bash

echo "inside shell cmds"
echo "variables $1 $2"

if lsof -Pi :3080 -sTCP:LISTEN -t >/dev/null ; then
    echo "port 3080 running"
    docker stop $(docker ps -q --filter ancestor=$2)
else
    echo "port 3080 not running"
fi

docker run -p 3080:3080 -d $1