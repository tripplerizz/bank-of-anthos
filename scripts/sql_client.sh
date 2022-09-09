#!/bin/bash



if [[ "$1" == "c" ]]; then
    echo "cockroach shell"
    kubectl exec -it cockroachdb-client-secure -- ./cockroach sql --certs-dir=/cockroach-certs --host=cockroachdb-public
else
    echo "ledger shell"
    kubectl exec -it ledgerdb-client-secure -- ./cockroach sql --certs-dir=/cockroach-certs --host=ledgerdb-public
fi
