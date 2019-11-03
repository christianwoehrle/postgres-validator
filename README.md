# postgres-validator
simple validator for the zalando-postgres operator in kubernetes

we use the zalando operator and istio in our cluster.

This test checks if our database setup works and if a client can access the database via istio mtls.


1. sets up a database and table in the postgres master
1. insert some rows into the table in the pstgres master
1. checks if the data is replicated into the postgres replica
1. checks that it is not possible to insert/update into the replicat
1. deletes the table and the database in the postgres master



