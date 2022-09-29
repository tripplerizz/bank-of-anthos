
cd deploy-kubernetes-manifests
for d in * ; do
    image=$(echo "$d" | sed "s/\.yaml//")
    sed "s/###replace###/image: gcr\.io\/$PROJECT_ID\/bank-of-anthos\/$image:latest/" $d  > ../dev-kubernetes-manifests/$d
done
