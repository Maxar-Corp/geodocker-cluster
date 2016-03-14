#!/bin/bash
echo "Installing GeoWave from source..."
docker cp ./support/geowave-install.sh master1:/data/geowave-install.sh
docker cp ./support/ingest-and-kde-gdelt.sh master1:/data/ingest-and-kde-gdelt.sh
docker cp ./support/setup-geowave.sh master1:/data/setup-geowave.sh
docker exec -it master1 bash -c ". ~/.bashrc;cd /data;/data/setup-geowave.sh"
echo "Installing GeoServer..."
cd ../geoserver;./install.sh;cd ../geowave
echo "Setting up GeoWave workspace on GeoServer..."
docker cp ./support/geoserver-geowave-workspace.tar master1:/data/geoserver-geowave-workspace.tar
docker cp ./support/setup-geoserver-geowave-workspace.sh master1:/data/setup-geoserver-geowave-workspace.sh
docker exec -it master1 bash -c ". ~/.bashrc;cd /data;/data/setup-geoserver-geowave-workspace.sh"
