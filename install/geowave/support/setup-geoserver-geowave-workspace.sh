#!/bin/bash
source geowave-env.sh
$GEOSERVER_HOME/bin/shutdown.sh
mkdir ${GEOSERVER_DATA_DIR}/workspaces/geowave
cd ${GEOSERVER_DATA_DIR}/workspaces/geowave
tar -xf ${STAGING_DIR}/geoserver-geowave-workspace.tar
sed -i -e s/'$HOSTNAME'/${HOSTNAME}/g ${GEOSERVER_DATA_DIR}/workspaces/geowave/gdelt/datastore.xml
sed -i -e s/'$INSTANCE'/${INSTANCE}/g ${GEOSERVER_DATA_DIR}/workspaces/geowave/gdelt/datastore.xml
sed -i -e s/'$HOSTNAME'/${HOSTNAME}/g ${GEOSERVER_DATA_DIR}/workspaces/geowave/gdelt_kde/kde_config.xml
sed -i -e s/'$INSTANCE'/${INSTANCE}/g ${GEOSERVER_DATA_DIR}/workspaces/geowave/gdelt_kde/kde_config.xml
sed -i -e s/'$EAST'/${EAST}/g ${GEOSERVER_DATA_DIR}/workspaces/geowave/gdelt_kde/gdeltevent_kde/coverage.xml
sed -i -e s/'$WEST'/${WEST}/g ${GEOSERVER_DATA_DIR}/workspaces/geowave/gdelt_kde/gdeltevent_kde/coverage.xml
sed -i -e s/'$NORTH'/${NORTH}/g ${GEOSERVER_DATA_DIR}/workspaces/geowave/gdelt_kde/gdeltevent_kde/coverage.xml
sed -i -e s/'$SOUTH'/${SOUTH}/g ${GEOSERVER_DATA_DIR}/workspaces/geowave/gdelt_kde/gdeltevent_kde/coverage.xml
sed -i -e s/'$EAST'/${EAST}/g ${GEOSERVER_DATA_DIR}/workspaces/geowave/gdelt/gdeltevent/featuretype.xml
sed -i -e s/'$WEST'/${WEST}/g ${GEOSERVER_DATA_DIR}/workspaces/geowave/gdelt/gdeltevent/featuretype.xml
sed -i -e s/'$NORTH'/${NORTH}/g ${GEOSERVER_DATA_DIR}/workspaces/geowave/gdelt/gdeltevent/featuretype.xml
sed -i -e s/'$SOUTH'/${SOUTH}/g ${GEOSERVER_DATA_DIR}/workspaces/geowave/gdelt/gdeltevent/featuretype.xml
sed -i -e s~'$GEOSERVER_DATA_DIR'~${GEOSERVER_DATA_DIR}~g ${GEOSERVER_DATA_DIR}/workspaces/geowave/gdelt_kde/coveragestore.xml
${GEOSERVER_HOME}/bin/startup.sh > /dev/null 2>&1 &
