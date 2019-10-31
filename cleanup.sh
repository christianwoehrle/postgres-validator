#/bin/sh


psql -h ${URL} -U ${USERNAME} -c "drop database test;"
if [ $? != 0 ]  
then
	echo "Error dropping database test"
	exit 1
fi


exit 0

