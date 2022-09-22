echo "creating certs and secrets"
rm ledger-db-certs/*
rm ledger-db-safe-directory/*
rm ledger-db-certs -r
rm ledger-db-safe-directory -r
kubectl delete secret ledgerdb.node
kubectl delete secret ledgerdb.client.root
mkdir ledger-db-certs
mkdir ledger-db-safe-directory
cockroach cert create-ca --certs-dir=ledger-db-certs --ca-key=ledger-db-safe-directory/ca.key
cockroach cert create-client root --certs-dir=ledger-db-certs --ca-key=ledger-db-safe-directory/ca.key
kubectl create secret generic ledgerdb.client.root --from-file=ledger-db-certs
cockroach cert create-node --certs-dir=ledger-db-certs --ca-key=ledger-db-safe-directory/ca.key \
    localhost 127.0.0.1 ledgerdb-public ledgerdb-public.default \
    ledgerdb-public.default.svc.cluster.local *.ledgerdb *.ledgerdb.default \
    *.ledgerdb.default.svc.cluster.local \
    --certs-dir=ledger-db-certs \
    --ca-key=ledger-db-safe-directory/ca.key
kubectl create secret generic ledgerdb.node --from-file=ledger-db-certs