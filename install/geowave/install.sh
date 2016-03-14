#!/bin/bash
echo "Installing GeoServer..."
cd ../geoserver;./install.sh;cd ../geowave
echo "Installing GeoWave from source..."
docker cp ./support master1:/data
docker exec -it master1 bash -c ". ~/.bashrc;cd /data;/data/setup-geowave.sh"
echo "Setting up GeoWave workspace on GeoServer..."
docker exec -it master1 bash -c ". ~/.bashrc;cd /data;/data/setup-geoserver-geowave-workspace.sh"
