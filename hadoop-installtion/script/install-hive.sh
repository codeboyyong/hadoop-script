#!/usr/bin/env bash

# get the environment from sbt or vagrant  or passed from command line

if [ "$HADOOP_HOST" == "" ]
then
    HADOOP_HOST=localhost
fi

#default values
BASE_DIR=~/hadoop-install
HADOOP_CONF_TEMPLATE_DIR=../conf

HADOOP_VERSION=2.5.0-cdh5.3.1

HIVE_VERSION=0.13.1-cdh5.3.1

if [ "$1" != "" ]
then
    HIVE_VERSION="$1"
fi
echo "HIVE_VERSION=$HIVE_VERSION"

if [ "$2" != "" ]
then
    HADOOP_VERSION="$2"
fi
echo "HADOOP_VERSION=$HADOOP_VERSION"

HADOOP_HOME=${BASE_DIR}/hadoop-${HADOOP_VERSION}
HIVE_HOME=${BASE_DIR}/hive-${HIVE_VERSION}

echo "--------------------------------------------------------------------"
echo "Starting install hive version $HIVE_VERSION for $HADOOP_VERSION ..."
echo "Installation folder is  ${HIVE_HOME}"
echo "--------------------------------------------------------------------"




if [ -d $HADOOP_HOME ]
    then
    echo "Found HADOOP_HOME ,will install hive with this hadoop: $HADOOP_HOME"
else
    echo "Folder $HADOOP_HOME does not exists will intall hadoop first"
    ./install-hadoop.sh $HADOOP_HOST $HADOOP_VERSION $BASE_DIR $HADOOP_CONF_TEMPLATE_DIR

    ./start-hadoop.sh $HADOOP_VERSION
fi

if [[ $HIVE_VERSION == *cdh* ]]
then
    HIVE_URL=http://archive.cloudera.com/cdh5/cdh/5/hive-$HIVE_VERSION.tar.gz
else
    HIVE_URL=http://apache.mirrors.tds.net/hive/apache-hive-$HIVE_VERSION/hive-bin.tar.gz
fi
echo "HIVE_URL=$HIVE_URL"


#rm -rf */.
HIVE_IMAGE_FILE="$BASE_DIR/hive-${HIVE_VERSION}.tar.gz"

if [ -f $HIVE_IMAGE_FILE ]
     then
    echo "Found HIVE_IMAGE_FILE = $HIVE_IMAGE_FILE "
else
    echo "File $HIVE_IMAGE_FILE does not exists"
    echo "Downloading from $HIVE_URL"
    echo "Please wait..."

    wget -q -O $HIVE_IMAGE_FILE $HIVE_URL
fi

echo "tar -xf $HIVE_IMAGE_FILE  -C $BASE_DIR"
echo "Please wait..."
tar -xf $HIVE_IMAGE_FILE  -C $BASE_DIR

#update the configuration
$HADOOP_HOME/bin/hadoop fs -mkdir /usr
$HADOOP_HOME/bin/hadoop fs -mkdir /usr/hive
$HADOOP_HOME/bin/hadoop fs -mkdir /usr/hive/warehouse
$HADOOP_HOME/bin/hadoop fs -chmod g+w /usr/hive/warehouse

echo "Install finished ,hive is installed in $HIVE_HOME"


