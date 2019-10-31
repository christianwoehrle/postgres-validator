# postgres-validator
simple validator for the zalando-postgres operator

this validator tests a postgres database that was setup with the
zalando operator.
the test 
1. sets up a database and table in the postgres master
1. insert some rows into the table in the pstgres master
1. checks if the data is replicated into the postgres replica
1. checks that it is not possible to insert/update into the replicat
1. deletes the table and the database in the postgres master



docker run -it --rm christianwoehrle/postgres-validator postgresql://user:pass@host:5432/db
docker run -it --rm christianwoehrle/postgres-validator -env URL_MASTER=ce-postgres -env URL_REPLICA=ce-postgres-repl

