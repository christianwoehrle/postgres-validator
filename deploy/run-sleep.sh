#!/usr/bin/env sh
#docker run -it --rm christianwoehrle/postgres-validator -env URL_MASTER=ce-postgres -env URL_REPLICA=ce-postgres-repl

NAMESPACE="${NAMESPACE:-microservice-ce}"

kubectl apply -f sleep.yaml -n ${NAMESPACE}


