
if [[ "$1" == "all" ]]; then
    skaffold run --default-repo=gcr.io/beezo-projects/bank-of-anthos
else
    skaffold run --default-repo=gcr.io/beezo-projects/bank-of-anthos -m $1
fi

