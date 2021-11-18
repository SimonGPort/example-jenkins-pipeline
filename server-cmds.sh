#!/usr/bin/env bash

docker stop $(docker ps -q --filter ancestor=simongport/react-nodejs-example:1.0)
docker run -p 3080:3080 -d simongport/react-nodejs-example:1.0