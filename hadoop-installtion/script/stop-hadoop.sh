#!/bin/sh



if [ "$1" != "" ];then
    HADOOP_VERSION="$1"
else
	HADOOP_VERSION=2.3.0-cdh5.0.0
	echo "HADOOP_VERSION not set, will use default one 2.3.0-cdh5.0.0."
	echo "You can run start-hadoop.sh version to start a hadoop with particular version, like start-hadoop.sh 2.3.0 "
	echo "currently we support 2.3.0-cdh5.0.0, 1.x, 2.x"
fi

HADOOP_HOME=~/hadoop-install

HADOOP_DIR=$HADOOP_HOME/hadoop-$HADOOP_VERSION

IS_YARN=`./is-yarn.sh "$HADOOP_VERSION"`

if [ "$IS_YARN" == "true" ];then
	$HADOOP_DIR/sbin/stop-dfs.sh
	$HADOOP_DIR/sbin/stop-yarn.sh
 else
	$HADOOP_DIR/bin/stop-dfs.sh
	$HADOOP_DIR/bin/stop-mapred.sh
 fi