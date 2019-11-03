#!/usr/bin/env sh

export POSTGRES_DB_NAME="${POSTGRES_DB_NAME:-ce-postgres}"
NAMESPACE="${NAMESPACE:-microservice-ce}"

envsubst < cleanup.yaml  | kubectl delete -n ${NAMESPACE} -f -
envsubst < cleanup.yaml  | kubectl apply  -n ${NAMESPACE} -f -


echo "echo show logs in a second, exist with ctrl-c"
sleep 1
echo "."
sleep 1
echo "."
sleep 1
echo "."


kubectl logs -f -ljob-name=postgres-cleanup-${POSTGRES_DB_NAME=} --all-containers=true

