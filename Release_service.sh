#!/bin/bash 
##############################################
#Author:		tony
#date:			2019-07-31
#Emil:			jmxct520@gmail.com
#Cropright:		2019@CQFG
##############################################
JARFILE=$1
Path=/home/microservices
BackupDIR=/home/backup
ProjectDir=/home/microservices/$JARFILE
DATE=$(date +"%Y%m%d%H%M")
Scriptpath=/home/devops
jobname=$JARFILE.jar
echo "Setting up JAVA environment"
bash /home/devops/set_java.sh
sleep 1
echo "Procedures in progress:"$1"..................."
echo "Create backup folders.............................."
if [ ! -d $BackupDIR/$JARFILE ]
then
	mkdir -p $BackupDIR/$JARFILE
fi
sleep 5
if [ ! -d $ProjectDir ] 
then
	mkdir -p $ProjectDir
fi
sleep 5
pid=$(ps -ef |grep java |grep "$JARFILE" | grep -v "grep" | awk '{print $2}')
echo "Old application process id:$pid"
if [ -n "$pid" ]
then
   echo "kill application process..............."
   kill -9 $pid
fi
sleep 5

if [ -d $ProjectDir/ ];then
echo "Backup works in progress"
cp -r $ProjectDir $BackupDIR/$JARFILE/$DATE
rm -rf $ProjectDir/*
else
echo "The folder does not exist and is not processed"
fi
sleep 5
echo "Copy script to project directory"
cp $Scriptpath/start.sh $ProjectDir
echo "Mobile Engineering to Directory"
mv $Path/$JARFILE.jar $ProjectDir/
echo "Starting the application"
cd $ProjectDir
bash start.sh $jobname
sleep 10
if [ $? != 0 ]; then
echo "Startup failure"
else
ps -ef |grep java |grep "$JARFILE" | grep -v "grep" | awk '{print $2}'
echo "Startup Success"
fi

echo "Keep 5 backup files................................"
cd $BackupDIR/$JARFILE/
ls -lt|awk 'NR>8{print $NF}'|xargs rm -rf
sleep 20
echo "Release completed........................."


