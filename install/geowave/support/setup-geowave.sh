#!/bin/bash
source geowave-env.sh
${STAGING_DIR}/install-from-source.sh
${STAGING_DIR}/ingest-and-kde-gdelt.sh
