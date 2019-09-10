#!/bin/bash 
##############################################
#Author:		tony
#date:			2019-07-31
#Emil:			jmxct520@gmail.com
#Cropright:		2019@CQFG
##############################################
shellDir=$(cd "$(dirname "$0")"; pwd)
shellName=$(echo $0 | awk -F'/' '{print $NF}' )
JAVA_HOME=""
source /etc/profile
a=$(ls -l ${JAVA_HOME} 2>&1 |grep 'jre' |wc -l)
if [ $a -ge 1 ] ;then
	echo 'java env test OK!'
#	ls -l $JAVA_HOME
	exit
else
	jh=/usr/lib/jvm/$(ls -l /usr/lib/jvm/ |grep ^d|grep -v "debug"|awk '{print $NF}')
	if [ "$JAVA_HOME" == "" ] ; then
		echo '#java enviroment setting' >>/etc/profile
	else
#		echo "sed -i \"/.*JAVA_HOME.*/d\"   /etc/profile"
		sed -i "/.*JAVA_HOME.*/d"   /etc/profile
	fi
	echo "export JAVA_HOME=$jh" >>/etc/profile
	echo 'export PATH=$JAVA_HOME/bin:$PATH' >>/etc/profile
	echo 'export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar'  >>/etc/profile
	echo >>/etc/profile
	source /etc/profile
	echo 'setting java env,test it!'
fi
