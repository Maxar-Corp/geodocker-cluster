#!/bin/bash
echo "Ingesting GeoWave sample data and running kernel density estimate..."
mkdir /data/gdelt;mkdir /data/gdelt;cd /data/gdelt
# just grab a few days as an example
wget http://data.gdeltproject.org/events/20160215.export.CSV.zip 
wget http://data.gdeltproject.org/events/20160216.export.CSV.zip 
wget http://data.gdeltproject.org/events/20160217.export.CSV.zip 
# ingest it, indexed spatial only, it can be indexed spatial-temporally by changing -dim, pre-split with 24 shard IDs
java -cp /data/geowave/deploy/target/geowave-deploy-0.9.0-tools.jar:/data/geowave/extensions/formats/gdelt/target/geowave-format-gdelt-0.9.0.jar mil.nga.giat.geowave.core.cli.GeoWaveMain -localingest -f gdelt -b /data/gdelt -dim spatial -gwNamespace geowave.gdelt -datastore accumulo -zookeeper $HOSTNAME:2181 -instance gis -user geowave -password geowave -partitionStrategy round_robin -numPartitions 24

# run a kde to produce a heatmap
hadoop jar /data/geowave/deploy/target/geowave-deploy-0.9.0-tools.jar -kde -featureType gdeltevent -minLevel 5 -maxLevel 17 -minSplits 32 -maxSplits 32 -coverageName gdeltevent_kde
 -hdfsHostPort ${HOSTNAME}:8020 -jobSubmissionHostPort ${HOSTNAME}:8032 -tileSize 1 -output_datastore accumulo -output_gwNamespace geowave.kde_gdelt 
-output_connectionParams "zookeeper=${HOSTNAME}:2181;instance=gis;user=geowave;password=geowave" -input_datastore accumulo -input_gwNamespace geowave.gdelt -input_connectionParams 
"zookeeper=${HOSTNAME}:2181;instance=gis;user=geowave;password=geowave"
