#!/bin/bash


if [[ "$1" == "c" ]]; then
    echo "cockroach shell"
    kubectl exec -it cockroachdb-0 -- /bin/bash
elif [[ "$1" == "t" ]]; then
    echo "transaction  shell"
    kubectl exec -it transactionhistory-6cd578ccd-tnnwj -- /bin/bash
else
    echo "ledger shell"
    kubectl exec -it ledgerdb-0  -- /bin/bash
fi
