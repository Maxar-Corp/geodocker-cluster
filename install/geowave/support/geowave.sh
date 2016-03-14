#!/bin/bash

java -cp /data/geowave/deploy/target/geowave-deploy-0.9.0-tools.jar:/data/geowave/extensions/formats/gdelt/target/geowave-format-gdelt-0.9.0.jar mil.nga.giat.geowave.core.cli.GeoWaveMain "$@"