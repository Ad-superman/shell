#/bin/bash
##############################################
#Author:		tony
#date:			2019-08-05
#Emil:			jmxct520@gmail.com
#Cropright:		2019@CQFG
##############################################
Filename=$1
Date=$(date +"%Y%m%d%H%M")
Dir=/usr/local/nginx/html
BackDir=/home/backup
if [ ! -d $BackDir/$Filename ] 
then 
	mkdir -p $BackDir/$Filename
fi 
sleep 2
if [ -d $Dir/$Filename/ ];then
echo "Backup in progress......."
mv $Dir/$Filename $BackDir/$Filename
mv $BackDir/$Filename/$Filename $BackDir/$Filename/$Date
else
echo "The folder does not exist and is not processed"
fi
sleep 5
#########Release Project######################
echo "Release Project $Filename"
unzip $Dir/$Filename".zip" -d $Dir
mv $Dir/dist $Dir/$Filename
chown www:www  -R $Dir/*
rm -rf $Dir/$Filename".zip"
echo "Successful release $Filename"







