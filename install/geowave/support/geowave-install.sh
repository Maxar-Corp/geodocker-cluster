#!/bin/bash
source geowave-env.sh
export HADOOP_VERSION=2.6.0
export GEOTOOLS_VERSION=14.2
export GEOSERVER_VERSION=2.8.2

rm -rf ./geowave
git clone --branch v0.9.0 --depth 1 https://github.com/ngageoint/geowave.git
cd ./geowave
## build from source
mvn clean install -DskipTests -Dfindbugs.skip=true -Dhadoop.version=${HADOOP_VERSION} -Dgeotools.version=${GEOTOOLS_VERSION} -Dgeoserver.version=${GEOSERVER_VERSION}

## build deployed artifacts using maven profiles
cd deploy
mvn package -P geowave-tools-singlejar -Dhadoop.version=${HADOOP_VERSION} -Dgeotools.version=${GEOTOOLS_VERSION} -Dgeoserver.version=${GEOSERVER_VERSION}
mvn package -P geotools-container-singlejar -Dhadoop.version=${HADOOP_VERSION} -Dgeotools.version=${GEOTOOLS_VERSION} -Dgeoserver.version=${GEOSERVER_VERSION}
mvn package -P accumulo-container-singlejar -Dhadoop.version=${HADOOP_VERSION} -Dgeotools.version=${GEOTOOLS_VERSION} -Dgeoserver.version=${GEOSERVER_VERSION}

## put geowave jars in appropriate locations
hadoop fs -mkdir -p /accumulo/classpath/geowave
hadoop fs -copyFromLocal ./target/geowave-deploy-0.9.0-accumulo-singlejar.jar /accumulo/classpath/geowave
cp ${STAGING_DIR}/geowave/deploy/target/geowave-deploy-0.9.0-geoserver-singlejar.jar ${GEOSERVER_HOME}/webapps/geoserver/WEB-INF/lib/geowave-geoserver.jar

## configure accumulo
cat <<EOF | accumulo shell -u root -p secret -e "createuser geowave"
geowave
geowave
EOF
accumulo shell -u root -p secret -e "createnamespace geowave"
accumulo shell -u root -p secret -e "grant NameSpace.CREATE_TABLE -ns geowave -u geowave"
accumulo shell -u root -p secret -e "config -s general.vfs.context.classpath.geowave=hdfs://${HOSTNAME}:9000/accumulo/classpath/geowave/[^.].*.jar"
accumulo shell -u root -p secret -e "config -ns geowave -s table.classpath.context=geowave"
