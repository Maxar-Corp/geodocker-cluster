#!/bin/bash

java -cp ${STAGING_DIR}/bin/geowave-tools.jar:${STAGING_DIR}/bin/plugins/* mil.nga.giat.geowave.core.cli.GeoWaveMain "$@"
