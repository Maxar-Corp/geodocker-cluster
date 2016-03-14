#!/bin/bash

docker cp ./support/geoserver-install.sh master1:/data/geoserver-install.sh
docker exec -it master1 bash -c ". ~/.bashrc;cd /data;/data/geoserver-install.sh"
