####This is a utility scripts to help you start hadoop cdh5 pseudo cluster

####prerequisite

1) ssh to localhost without password,you can achieve this by run the following command

`ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa`
 
`cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys` 

2) make sure JAVA_HOME exists in your shell .

3) make sure you have at least 8G memory, 16 is prefer, since yarn cluster and job need consume lots of memory .

####Start/Stop pseudo cluster
This will start the basic cluster  with HDFS and Mapreduce.

	start-hadoop.sh
		Will start cdh5 in your local machine, first time will auto download and install into ~/hadoop-install, it might take several minutes
	
	stop-hadoop.sh
		Stop the hadoop cdh5
		
	runHadoopPI.sh
		After started, you can run this script to check whether the cdh5 cluster is OK

####Accept one argument $version
####download from http://apache.mirrors.tds.net/hadoop/common/hadoop-2.5.1/
if not specified, the version will be 2.3.0-cdh5.0.0
	
	tested with the following version in Mac OS X :
	
	start-hadoop.sh 1.2.1
	start-hadoop.sh 2.5.0-cdh5.3.1
	start-hadoop.sh 2.3.0-cdh5.0.0
	start-hadoop.sh 2.4.0
	start-hadoop.sh 2.5.1
	start-hadoop.sh 2.6.0

	
####Installtion of other hadoop components

#####Hive
Only tested with

HADOOP_VERSION=2.5.0-cdh5.3.1

HIVE_VERSION=0.13.1-cdh5.3.1 

you can run the following comamnd to install it
	
`$./install-hive.sh 0.13.1-cdh5.3.1 2.5.0-cdh5.3.1`
	
	 	HIVE_VERSION=0.13.1-cdh5.3.1 
	 	HADOOP_VERSION=2.5.0-cdh5.3.1
 		Starting install hive version 0.13.1-cdh5.3.1 for 2.5.0-cdh5.3.1 ...
		Installation folder is  /Users/zhaoyong/hadoop-install/hive-0.13.1-cdh5.3.1-hadoop-2.5.0-cdh5.3.1
		--------------------------------------------------------------------
		Found HADOOP_DIR ,will install hive with this hadoop: /Users/zhaoyong/hadoop-install/hadoop-2.5.0-cdh5.3.1
		HIVE_URL=http://archive.cloudera.com/cdh5/cdh/5/hive-0.13.1-cdh5.3.1.tar.gz
		File /Users/zhaoyong/hadoop-install/hive-0.13.1-cdh5.3.1-hadoop-2.5.0-cdh5.3.1.tar.gz does not exists
		Downloading from http://archive.cloudera.com/cdh5/cdh/5/hive-0.13.1-cdh5.3.1.tar.gz
		Please wait...
		tar -xf /Users/zhaoyong/hadoop-install/hive-0.13.1-cdh5.3.1-hadoop-2.5.0-cdh5.3.1.tar.gz  -C /Users/zhaoyong/hadoop-install
		Please wait...
		
		Install finished ,hive is installed in /Users/zhaoyong/hadoop-install/hive-0.13.1-cdh5.3.1-hadoop-2.5.0-cdh5.3.1

Then you need some manul configure from here http://doctuts.readthedocs.org/en/latest/hive.html

#####Pig
#####Sqoop

	