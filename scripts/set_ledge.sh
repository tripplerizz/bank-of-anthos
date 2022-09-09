
#
#CREATE USER  bank_admin WITH LOGIN PASSWORD 'anthos_bank_pwd';
#
#
#"postgres://bank_admin@cockroachdb-public:26257/bank_anthos?sslmode=verify-full&sslcert=/cockroach/cockroach-certs/client.root.crt&sslkey=/cockroach/cockroach-certs/client.root.key&sslrootcert=/cockroach/cockroach-certs/ca.crt"
#
#
#login to admin console, check the certs freshness for user -- root -- if new ones needed recreate. redeploy

#!/bin/bash


if [[ "$1" == "c" ]]; then
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
else
    echo "printing init/start command"
    echo "cockroach start --certs-dir=/cockroach/cockroach-certs --advertise-host=$(hostname -f) --http-addr=0.0.0.0 --join=ledgerdb-0.ledgerdb,ledgerdb-1.ledgerdb --cache=\$(expr \$MEMORY_LIMIT_MIB / 4)MiB --max-sql-memory=\$(expr \$MEMORY_LIMIT_MIB / 4)MiB"
fi




# kubectl create -f bring-your-own-certs-statefulset.yaml
#kubectl exec -it ledgerdb-0 -- /cockroach/cockroach init --certs-dir=/cockroach/cockroach-certs


