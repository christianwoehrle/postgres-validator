#!/usr/bin/env sh
#docker run -it --rm christianwoehrle/postgres-validator -env URL_MASTER=ce-postgres -env URL_REPLICA=ce-postgres-repl


NAMESPACE="${NAMESPACE:-microservice-ce}"
kubectl apply -f postgres-crd.yaml -n ${NAMESPACE} 

kubectl delete -f test.yaml -n ${NAMESPACE}   2> /dev/null
kubectl apply -f test.yaml -n ${NAMESPACE}   

echo "echo show logs in a second, exist with ctrl-c"
sleep 1
echo "."
sleep 1
echo "."
sleep 1
echo "."
sleep 1
echo "."
sleep 1
echo "."
sleep 1
echo "=================="
kubectl logs -f -ljob-name=postgres-test --all-containers=true


