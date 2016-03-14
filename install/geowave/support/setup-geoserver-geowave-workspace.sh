export GEOSERVER_HOME=/data/geoserver/geoserver                             
export GEOSERVER_DATA_DIR=$GEOSERVER_HOME/data_dir
$GEOSERVER_HOME/bin/shutdown.sh
cp /data/geowave/deploy/target/geowave-deploy-0.9.0-geoserver-singlejar.jar ${GEOSERVER_HOME}/webapps/geoserver/WEB-INF/lib/geowave-geoserver.jar
mkdir ${GEOSERVER_DATA_DIR}/workspaces/geowave
cd ${GEOSERVER_DATA_DIR}/workspaces/geowave
tar -xf /data/geoserver-geowave-workspace.tar
sed -i -e s/'$HOSTNAME'/${HOSTNAME}/g ${GEOSERVER_DATA_DIR}/workspaces/geowave/gdelt/datastore.xml
sed -i -e s/'$HOSTNAME'/${HOSTNAME}/g ${GEOSERVER_DATA_DIR}/workspaces/geowave/gdelt_kde/kde_config.xml
sed -i -e s/'$GEOSERVER_DATA_DIR'/'\/data\/geoserver\/geoserver\/data_dir'/g ${GEOSERVER_DATA_DIR}/workspaces/geowave/gdelt_kde/coveragestore.xml
${GEOSERVER_HOME}/bin/startup.sh > /dev/null 2>&1 &
