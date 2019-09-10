#!/bin/bash 
#################################################
#Author:		tony
#date:			2019-07-31
#Emil:			jmxct520@gmail.com
#Cropright:		2019@CQFG
#################################################
jobname=$1
nohup java -server -Xms512m -Xmx4096m -XX:PermSize=128M -XX:MaxPermSize=128m -jar $jobname > /dev/null 2>&1 &