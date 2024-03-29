#!/usr/bin/env sh

echo "URL for postgres Master: ${URL_MASTER}"
echo "URL for postgres Replicat: ${URL_REPLICA}"



echo "sleep for 10 seconds in case an istio sidecar has to come up"
sleep 10



echo "test postgres master and replica with URLs ${URL_MASTER} and ${URL_REPLICA}"

psql -h ${URL_MASTER} -U ${USERNAME} -c "create database test;"
if [ $? != 0 ]  
then
	echo "Error creating database test"
	exit 1
fi

echo "database created at ${URL_MASTER}"

psql -h ${URL_MASTER} -U ${USERNAME} -c "create table posts (
id integer,
title character varying(100),
content text, 
published_at timestamp without time zone,
type character varying(100)
);
"

if [ $? != 0 ]  
then
	echo "Error creating table"
	exit 1
fi

echo "table created at ${URL_MASTER}"

psql -h ${URL_MASTER} -U ${USERNAME} -c "
insert into posts (id, title, content, published_at, type) values
(100, 'Intro to SQL', 'Epic SQL Content', '2018-01-01', 'SQL'),
(101, 'Intro to PostgreSQL', 'PostgreSQL is awesome!', now(), 'PostgreSQL');
"


if [ $? != 0 ]  
then
	echo "Error inserting rows"
	exit 1
fi

psql -h ${URL_MASTER} -U ${USERNAME} -c "commit;"
echo "rows inserted at ${URL_MASTER}"
if [ $? != 0 ]  
then
	echo "Error committing rows"
	exit 1
fi

echo "rows committed at ${URL_MASTER}"





psql -h ${URL_MASTER} -U ${USERNAME} -qat -c "select * from posts;" 

if [ $? != 0 ]  
then
	echo "Error selecting rows"
	exit 1
fi



echo "rows found at ${URL_MASTER}"

psql -h ${URL_MASTER} -U ${USERNAME} -qat -c "select * from posts;" > /tmp/t 
ROWS=$(cat /tmp/t | wc -l)

if [ $ROWS != 4 ]  
then
	echo "Expected 4 Rows, got $ROWS"
	exit 1
fi

echo "expected number of rows found at ${URL_MASTER}"

psql -h ${URL_REPLICA} -U ${USERNAME} -qat -c "select * from posts;" 

if [ $? != 0 ]  
then
	echo "Error selecting rows"
	exit 1
fi

psql -h ${URL_REPLICA} -U ${USERNAME} -qat -c "select * from posts;"  > /tmp/t2
ROWS2=$(cat /tmp/t2 | wc -l)

if [ $ROWS2 != 4 ]  
then
	echo "Expected 4 Rows, got $ROWS2"
	exit 1
fi

echo "expected number of rows found at ${URL_REPLICA}"

psql -h ${URL_REPLICA} -U ${USERNAME} -c "delete from posts where id!=1;" 

if [ $? == 0 ]
then
        echo "Deleting succeeded on the read only replica, this is an error"
        exit 1
fi

echo "no insert possible in read replica at ${URL_REPLICA}  --> that's correct"

psql -h ${URL_MASTER} -U ${USERNAME} -c "delete from posts where id!=1;" 

if [ $? != 0 ]
then
        echo "Error deleting rows on the master"
        exit 1
fi

echo "deleted rows in ${URL_MASTER} "
psql -h ${URL_MASTER} -U ${USERNAME} -c "commit;"
echo "commit  at ${URL_MASTER}"
if [ $? != 0 ]  
then
        echo "Error committing"
        exit 1
fi

echo "rows committed at ${URL_MASTER}"


psql -h ${URL_MASTER} -U ${USERNAME} -c "drop table posts" 

if [ $? != 0 ]
then
        echo "Error dropping table on the master"
        exit 1
fi

psql -h ${URL_MASTER} -U ${USERNAME} -c "drop database test" 

if [ $? != 0 ]
then
        echo "Error deleting database on the master"
        exit 1
fi

echo "success"


echo "stop istio sidecar container"
curl -X POST localhost:15000/quitquitquit


exit 0
