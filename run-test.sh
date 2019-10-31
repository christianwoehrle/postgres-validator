#!/usr/bin/env sh
#docker run -it --rm christianwoehrle/postgres-validator -env URL_MASTER=ce-postgres -env URL_REPLICA=ce-postgres-repl


kubectl delete -f test.yaml 2> /dev/null
kubectl apply -f test.yaml
