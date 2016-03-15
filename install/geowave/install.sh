#!/bin/bash
source support/geowave-env.sh

echo "Installing GeoServer..."
cd ../geoserver;./install.sh;cd ../geowave
echo "Installing GeoWave from source..."
docker cp ./support master1:${STAGING_DIR}
docker exec -it master1 bash -c ". ~/.bashrc;cd ${STAGING_DIR};${STAGING_DIR}/setup-geowave.sh"
echo "Setting up GeoWave workspace on GeoServer..."
docker exec -it master1 bash -c ". ~/.bashrc;cd ${STAGING_DIR};${STAGING_DIR}/setup-geoserver-geowave-workspace.sh"
