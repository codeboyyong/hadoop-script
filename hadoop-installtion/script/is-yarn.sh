#!/bin/sh
if [ "$1" != "" ]
then
	HADOOP_VERSION="$1"
else
	echo "Please input hadoop version"
fi

IS_YARN=false

if [[ $HADOOP_VERSION == 2* ]]
then
	IS_YARN=true
fi	 

echo $IS_YARN
