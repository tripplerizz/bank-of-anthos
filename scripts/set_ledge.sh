
#
#CREATE USER  bank_admin WITH LOGIN PASSWORD 'anthos_bank_pwd';
#
#
#"postgres://bank_admin@cockroachdb-public:26257/bank_anthos?sslmode=verify-full&sslcert=/cockroach/cockroach-certs/client.root.crt&sslkey=/cockroach/cockroach-certs/client.root.key&sslrootcert=/cockroach/cockroach-certs/ca.crt"
#
#
#login to admin console, check the certs freshness for user -- root -- if new ones needed recreate. redeploy

#!/bin/bash


echo "printing init/start command"
echo "cockroach start --certs-dir=/cockroach/cockroach-certs --advertise-host=$(hostname -f) --http-addr=0.0.0.0 --join=ledgerdb-0.ledgerdb,ledgerdb-1.ledgerdb --cache=\$(expr \$MEMORY_LIMIT_MIB / 4)MiB --max-sql-memory=\$(expr \$MEMORY_LIMIT_MIB / 4)MiB"




# kubectl create -f bring-your-own-certs-statefulset.yaml
#kubectl exec -it ledgerdb-0 -- /cockroach/cockroach init --certs-dir=/cockroach/cockroach-certs


