#!/bin/sh

HADOOP_VERSION=2.5.0-cdh5.3.1
BASE_DIR=~/hadoop-install
HIVE_VERSION=0.13.1-cdh5.3.1


if [ "$1" != "" ]
then
    HIVE_VERSION="$1"
    echo "HIVE_VERSION=$HIVE_VERSION"

else
    echo "HIVE_VERSION not set, will use default one $HIVE_VERSION ."
fi

if [ "$2" != "" ]
then
    HADOOP_VERSION="$2"
    echo "HADOOP_VERSION=$HADOOP_VERSION"
else
    echo "HADOOP_VERSION not set, will use default one $HADOOP_VERSION ."
fi


HADOOP_HOME=${BASE_DIR}/hadoop-$HADOOP_VERSION
HIVE_HOME=${BASE_DIR}/hive-${HIVE_VERSION}

echo "HADOOP_VERSION=$HADOOP_VERSION"

if [ ! -d $HIVE_HOME ]; then
	echo "Will use $HIVE_HOME as installtion base"
    ./install-hive.sh $HIVE_VERSION $HADOOP_VERSION


fi


echo "starting hadoop ..."

./start-hadoop.sh $HADOOP_VERSION

echo "setting environment for hive ..."

export HIVE_HOME="$HIVE_HOME"
export HADOOP_HOME="$HADOOP_HOME"

PATH=$PATH:$HIVE_HOME/bin:$HADOOP_HOME/bin
export PATH

echo "HIVE_HOME = $HIVE_HOME"
echo "HADOOP_HOME = $HADOOP_HOME"
echo "PATH = $PATH"

echo "running $HIVE_HOME/bin/hive ..."

hive