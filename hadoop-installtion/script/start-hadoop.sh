#!/bin/sh



HADOOP_HOST=localhost
HADOOP_HOME=~/hadoop-install
HADOOP_CONF_TEMPLATE_DIR=../conf


if [ "$1" != "" ]
then
    HADOOP_VERSION="$1"
else
	HADOOP_VERSION=2.3.0-cdh5.0.0
	echo "HADOOP_VERSION not set, will use default one 2.3.0-cdh5.0.0."
	echo "You can run start-hadoop.sh version to start a hadoop with particular version, like start-hadoop.sh 2.3.0 "
	echo "currently we support 0.13.1-cdh5.3.0"
fi


HADOOP_DIR=$HADOOP_HOME/hadoop-$HADOOP_VERSION

echo "HADOOP_VERSION=$HADOOP_VERSION"

if [ ! -d $HADOOP_DIR ]; then
	echo "Will use $HADOOP_DIR as installtion base"
    ./install-hadoop.sh $HADOOP_HOST $HADOOP_VERSION $HADOOP_HOME $HADOOP_CONF_TEMPLATE_DIR
fi

IS_YARN=`./is-yarn.sh "$HADOOP_VERSION"`

echo "IS_YARN=$IS_YARN"

if [ "$IS_YARN" == "true" ];then
	$HADOOP_DIR/sbin/start-dfs.sh
	$HADOOP_DIR/sbin/start-yarn.sh
	open http://$HADOOP_HOST:8088
else
	$HADOOP_DIR/bin/start-dfs.sh
	$HADOOP_DIR/bin/start-mapred.sh
	open http://$HADOOP_HOST:50030
fi

open http://$HADOOP_HOST:50070