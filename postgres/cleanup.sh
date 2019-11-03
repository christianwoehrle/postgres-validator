#!/usr/bin/env sh

echo "URL for postgres Master: ${URL_MASTER}"


echo "sleep for 10 seconds in case an istio sidecar has to come up"
sleep 10


psql -h ${URL_MASTER} -U ${USERNAME} -c "drop table posts" 

if [ $? != 0 ]
then
        echo "Error dropping table on the master"
fi

psql -h ${URL_MASTER} -U ${USERNAME} -c "drop database test;"
if [ $? != 0 ]  
then
	echo "Error dropping database test"
	exit 1
fi


echo "stop istio sidecar container"
curl -X POST localhost:15000/quitquitquit

echo "success"

exit 0

