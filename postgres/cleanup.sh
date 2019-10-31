#!/usr/bin/env sh


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

echo "success"
exit 0

