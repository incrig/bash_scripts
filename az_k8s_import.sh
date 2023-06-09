# Mass import AZ Based k8s clusters by cluster name mask
# Requires jq tool to run
for i in $(az aks list --query "[].{name:name,rg:resourceGroup}" | jq -r '.[] | select(.name|test("CLUSTERNAME.")) | [.name,.rg] | @tsv'); do az aks get-credentials --resource-group $(echo $i | awk '{ print $2 }' ) --name $(echo $i | awk '{ print $1 }') -a; done

# Mass edit URL in case private endpoint is unreachable
# This replace expects that cluster are named like cluser-uid-[dev..|test]-aks
sed -i -r "s|(server: https:\/\/cluster)(.*dev)(.*-aks)(-[a-zA-Z0-9]{8}.*:443)$|\1\2\3.dev.domain.com:443|; s|(server: https:\/\/cluster)(.*-aks)(-[a-zA-Z0-9]{8}.*:443)$|\1\2.test.domain.com:443|" config

# In case Auth Cert needs to be changed to custom one
# Requires yq tool to run
yq e -i '(.clusters.[] | select(.name == "cluster-*-aks") | .cluster.certificate-authority-data) = "CERTVALUE"' config
