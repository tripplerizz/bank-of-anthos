echo "creating certs and secrets"
rm certs/*
rm my-safe-directory/*
rm certs -r
rm my-safe-directory -r
kubectl delete secret cockroachdb.node
kubectl delete secret cockroachdb.client.root
mkdir certs
mkdir my-safe-directory
cockroach cert create-ca --certs-dir=certs --ca-key=my-safe-directory/ca.key
cockroach cert create-client root --certs-dir=certs --ca-key=my-safe-directory/ca.key
kubectl create secret generic cockroachdb.client.root --from-file=certs
cockroach cert create-node --certs-dir=certs --ca-key=my-safe-directory/ca.key \
 localhost 127.0.0.1 cockroachdb-public cockroachdb-public.default \
 cockroachdb-public.default.svc.cluster.local *.cockroachdb *.cockroachdb.default \
 *.cockroachdb.default.svc.cluster.local
kubectl create secret generic cockroachdb.node --from-file=certs
