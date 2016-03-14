if [ -d "/data/geoserver/geoserver" ]; then
  /data/geoserver/geoserver/bin/shutdown.sh
  rm -r /data/geoserver/geoserver
fi
if [ -z $GEOSERVER_DOWNLOAD_BASE ]; then
	GEOSERVER_DOWNLOAD_BASE=http://ares.boundlessgeo.com/geoserver/release
fi

if [ -z $GEOSERVER_VERSION ]; then
	GEOSERVER_VERSION=2.8.2
fi
mkdir /data/geoserver
GEOSERVER_ARTIFACT=/data/geoserver/geoserver.zip
if [ ! -f "$GEOSERVER_ARTIFACT" ]; then
	curl ${GEOSERVER_DOWNLOAD_BASE}/${GEOSERVER_VERSION}/geoserver-${GEOSERVER_VERSION}-bin.zip > $GEOSERVER_ARTIFACT
fi
apt-get install unzip
unzip $GEOSERVER_ARTIFACT -d /data/geoserver
mv /data/geoserver/geoserver-$GEOSERVER_VERSION /data/geoserver/geoserver
export GEOSERVER_HOME=/data/geoserver/geoserver
export GEOSERVER_DATA_DIR=$GEOSERVER_HOME/data_dir
${GEOSERVER_HOME}/bin/start.sh > /dev/null 2>&1 &
