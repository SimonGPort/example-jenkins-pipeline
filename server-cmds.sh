#!/usr/bin/env bash

echo "inside shell cmds"
docker stop $(docker ps -q --filter ancestor=simongport/react-nodejs-example:1.4)
docker run -p 3080:3080 -d simongport/react-nodejs-example:1.5