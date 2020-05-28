# ========================================================================
# Copyright (c) 2020 Netcrest Technologies, LLC. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ========================================================================

#
# Enter app specifics in this file.
#

# Cluster level variables:
# ------------------------
# BASE_DIR - padogrid base dir
# ETC_DIR - Cluster etc dir
# LOG_DIR - Cluster log dir

# App level variables:
# --------------------
# APPS_DIR - <padogrid>/apps dir
# APP_DIR - App base dir
# APP_ETC_DIR - App etc dir
# APP_LOG_DIR - App log dir

BLUE_FILE=$APP_DIR/etc/hazelcast-client-blue.xml
GREEN_FILE=$APP_DIR/etc/hazelcast-client-green.xml
if [[ $OS_NAME == CYGWIN* ]]; then
   BLUE_FILE=$(cygpath -wp "$BLUE_FILE")
   GREEN_FILE=$(cygpath -wp "$GREEN_FILE")
fi

# Set JAVA_OPT to include your app specifics.
JAVA_OPTS="-Xms1g -Xmx1g"

TRUST_CERT_COLLECTION_FILE=$CLUSTER_DIR/etc/ssl/lab.crt
KEY_FILE=$CLUSTER_DIR/etc/ssl/lab.key
KEY_CERT_CHAIN_FILE=$TRUST_CERT_COLLECTION_FILE

#OS_NAME=`uname`
if [[ $OS_NAME == CYGWIN* ]]; then
   TRUST_CERT_COLLECTION_FILE=$(cygpath -wp "$TRUST_CERT_COLLECTION_FILE")
   KEY_FILE=$(cygpath -wp "$KEY_FILE")
   KEY_CERT_CHAIN_FILE=$(cygpath -wp "$KEY_CERT_CHAIN_FILE")
fi
   
JAVA_OPTS="$JAVA_OPTS \
-DtrustCertCollectionFile="$TRUST_CERT_COLLECTION_FILE" \
-DkeyFile="$KEY_FILE" \
-DkeyCertChainFile="$KEY_CERT_CHAIN_FILE" \
-Djavax.net.debug=SSL"

# For blue/green tests
# These are imported from hazelcast-client-failover.xml which is used
# to configure the clients apps only if the -failover option is specified.
JAVA_OPTS="$JAVA_OPTS -Dhazelcast-addon.blue=$BLUE_FILE \
-Dhazelcast-addon.green=$GREEN_FILE" 

# HAZELCAST_CLIENT_CONFIG_FILE defaults to etc/hazelcast-client.xml
# HAZELCAST_CLIENT_FAILOVER_CONFIG_FILE defaults to etc/hazelcast-client-failover.xml. It is
# used only if the -failover option is specified.
JAVA_OPTS="$JAVA_OPTS -Dhazelcast.client.config=$HAZELCAST_CLIENT_CONFIG_FILE \
-Dhazelcast.client.failover.config=$HAZELCAST_CLIENT_FAILOVER_CONFIG_FILE"

# CLASSPATH="$CLASSPATH"
