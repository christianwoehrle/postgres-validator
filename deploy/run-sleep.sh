#!/usr/bin/env sh

export POSTGRES_DB_NAME="${POSTGRES_DB_NAME:-ce-postgres}"
NAMESPACE="${NAMESPACE:-microservice-ce}"

envsubst < sleep.yaml  | kubectl apply  -n ${NAMESPACE} -f -



