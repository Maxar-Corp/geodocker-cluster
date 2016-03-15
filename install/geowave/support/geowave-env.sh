## These environment variables are particular to building from source
export STAGING_DIR=/data/geowave-staging
export PATH=$PATH:${STAGING_DIR}/bin

## These environment variables are general
export INSTANCE=gis
export TIME_REGEX=2015111[34]
export EAST=49.04694
export WEST=48.658291
export NORTH=2.63791
export SOUTH=2.08679
export HDFS_PORT=9000
export RESOURCE_MAN_PORT=8040
export NUM_PARTITIONS=1
export GEOSERVER_HOME=/data/geoserver/geoserver                             
export GEOSERVER_DATA_DIR=$GEOSERVER_HOME/data_dir
export GEOWAVE_TOOL_JAVA_OPT=-Xmx1024m
