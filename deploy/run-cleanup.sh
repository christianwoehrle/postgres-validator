#!/usr/bin/env sh
#docker run -it --rm christianwoehrle/postgres-validator -env URL_MASTER=ce-postgres -env URL_REPLICA=ce-postgres-repl

NAMESPACE="${NAMESPACE:-microservice-ce}"

kubectl delete -f cleanup.yaml -n ${NAMESPACE} 2> /dev/null
kubectl apply -f cleanup.yaml -n ${NAMESPACE}

echo "echo show logs in a second, exist with ctrl-c"
sleep 1
echo "."
sleep 1
echo "."
sleep 1
echo "."


kubectl logs -f -ljob-name=postgres-cleanup --all-containers=true

