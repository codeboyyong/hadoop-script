#!/usr/bin/env bash

# get the environment from sbt or vagrant  or passed from command line
#$1 :HADOOP_HOST=localhost
#$2 :HADOOP_VERSION=2.3.0-cdh5.0.0
#$3 :HADOOP_URL=http://archive.cloudera.com/cdh5/cdh/5/hadoop-2.3.0-cdh5.0.0.tar.gz
#$4 :HADOOP_DIR=~/hadoop-install
#$5 :HADOOP_CONF_TEMPLATE_DIR=../conf 

if [ "$1" != "" ]
then
    HADOOP_HOST="$1"
fi
echo "HADOOP_HOST=$HADOOP_HOST"

if [ "$2" != "" ]
then
    HADOOP_VERSION="$2"
fi
echo "HADOOP_VERSION=$HADOOP_VERSION"

if [ "$3" != "" ]
then
    HADOOP_DIR="$3"
fi
echo "HADOOP_DIR=$HADOOP_DIR"

if [ "$4" != "" ]
then
    HADOOP_CONF_TEMPLATE_DIR="$4"
fi
echo "HADOOP_CONF_TEMPLATE_DIR=$HADOOP_CONF_TEMPLATE_DIR"

if [[ $HADOOP_VERSION == *cdh* ]]
then
    HADOOP_URL=http://archive.cloudera.com/cdh5/cdh/5/hadoop-$HADOOP_VERSION.tar.gz
else
    HADOOP_URL=http://apache.mirrors.tds.net/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz
fi

echo "HADOOP_URL=$HADOOP_URL"

echo "-------------------------------------------------------"
echo "Starting install hadoop version $HADOOP_VERSION"

#1 download installation image
#if  exsits, ask wheter to remove it
  #rm -r ./hadoop-2.3.0
#if [ -d $HADOOP_HOME ]
#    then
#    echo "Will install into $HADOOP_HOME "
#else
#    echo "File $HADOOP_HOME does not exists will create one"
#    mkdir $HADOOP_HOME
#fi


HADOOP_HOME=${HADOOP_DIR}/hadoop-${HADOOP_VERSION}


if [ -d $HADOOP_HOME ]
    then
    echo "Found HADOOP_HOME ,will overwrite in the install"
else
    echo "File $HADOOP_HOME does not exists will create one"
    mkdir -p $HADOOP_HOME
fi

#rm -rf */.
HADOOP_IMAGE_FILE="$HADOOP_DIR/hadoop-${HADOOP_VERSION}.tar.gz"

if [ -f $HADOOP_IMAGE_FILE ]
     then
    echo "Found HADOOP_IMAGE_FILE = $HADOOP_IMAGE_FILE "
else
    echo "File $HADOOP_IMAGE_FILE does not exists"
    echo "Downloading from $HADOOP_URL"
    echo "Please wait..."

    wget -q -O $HADOOP_IMAGE_FILE $HADOOP_URL
fi

echo "tar -xf $HADOOP_IMAGE_FILE  -C $HADOOP_DIR"
echo "Please wait..."
tar -xf $HADOOP_IMAGE_FILE  -C $HADOOP_DIR

#update the configuration
 



if [[ $HADOOP_VERSION == 1* ]]
then
	CONF_DIR=conf
	echo "cp -f $HADOOP_CONF_TEMPLATE_DIR/1.x/*.xml $HADOOP_HOME/conf"
	cp -f $HADOOP_CONF_TEMPLATE_DIR/1.x/*.xml $HADOOP_HOME/conf

elif [[ $HADOOP_VERSION == *cdh* ]]
then
	CONF_DIR=etc/hadoop
	echo "cp -f $HADOOP_CONF_TEMPLATE_DIR/$HADOOP_VERSION/*.xml $HADOOP_HOME/etc/hadoop"
	cp -f $HADOOP_CONF_TEMPLATE_DIR/$HADOOP_VERSION/*.xml $HADOOP_HOME/etc/hadoop

else
	CONF_DIR=etc/hadoop
	echo "cp -f $HADOOP_CONF_TEMPLATE_DIR/2.x/*.xml $HADOOP_HOME/conf"
	 cp -f $HADOOP_CONF_TEMPLATE_DIR/2.x/*.xml $HADOOP_HOME/etc/hadoop
fi	


for FILE in `ls $HADOOP_HOME/$CONF_DIR/*.xml`
do
 sed 's|HADOOP_HOST|'$HADOOP_HOST'|g' < $FILE > TMP_00
 sed 's|HADOOP_HOME|'$HADOOP_HOME'|g' < TMP_00 > TMP_01
 mv TMP_01 $FILE
done

rm TMP_00


mkdir $HADOOP_HOME/data
mkdir $HADOOP_HOME/name
mkdir $HADOOP_HOME/tmp

#update hadoop env and yarn env

if [ "$JAVA_HOME" != "" ]
then
    echo "updating java home for hadoop env : $JAVA_HOME"
else
    echo "JAVA_HOME not found"
    exit

fi



#update the start script

#install service

echo "$HADOOP_HOME/bin/hadoop namenode -format"
$HADOOP_HOME/bin/hadoop namenode -format

# make it can ssh to localhost

#cd ~/.ssh
#ssh-keygen -t rsa -P ""
#cat  ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

# make it can ssh to each other ssh

echo "Install finished into $HADOOP_HOME"


