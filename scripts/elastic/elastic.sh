#!/usr/bin/env bash

ELASTIC_VERSION=1.9.1
RCol='\e[0m'    # Text Reset

# Regular           Bold                Underline           High Intensity      BoldHigh Intens     Background          High Intensity Backgrounds
Bla='\e[0;30m';     BBla='\e[1;30m';    UBla='\e[4;30m';    IBla='\e[0;90m';    BIBla='\e[1;90m';   On_Bla='\e[40m';    On_IBla='\e[0;100m';
Red='\e[0;31m';     BRed='\e[1;31m';    URed='\e[4;31m';    IRed='\e[0;91m';    BIRed='\e[1;91m';   On_Red='\e[41m';    On_IRed='\e[0;101m';
Gre='\e[0;32m';     BGre='\e[1;32m';    UGre='\e[4;32m';    IGre='\e[0;92m';    BIGre='\e[1;92m';   On_Gre='\e[42m';    On_IGre='\e[0;102m';
Yel='\e[0;33m';     BYel='\e[1;33m';    UYel='\e[4;33m';    IYel='\e[0;93m';    BIYel='\e[1;93m';   On_Yel='\e[43m';    On_IYel='\e[0;103m';
Blu='\e[0;34m';     BBlu='\e[1;34m';    UBlu='\e[4;34m';    IBlu='\e[0;94m';    BIBlu='\e[1;94m';   On_Blu='\e[44m';    On_IBlu='\e[0;104m';
Pur='\e[0;35m';     BPur='\e[1;35m';    UPur='\e[4;35m';    IPur='\e[0;95m';    BIPur='\e[1;95m';   On_Pur='\e[45m';    On_IPur='\e[0;105m';
Cya='\e[0;36m';     BCya='\e[1;36m';    UCya='\e[4;36m';    ICya='\e[0;96m';    BICya='\e[1;96m';   On_Cya='\e[46m';    On_ICya='\e[0;106m';
Whi='\e[0;37m';     BWhi='\e[1;37m';    UWhi='\e[4;37m';    IWhi='\e[0;97m';    BIWhi='\e[1;97m';   On_Whi='\e[47m';    On_IWhi='\e[0;107m';


# ELASTIC K8S OPERATOR
echo -e "${On_IBlu}INSTALL ELASTICSEARCH AND KIBANA${RCol}"
kubectl create -f https://download.elastic.co/downloads/eck/$ELASTIC_VERSION/crds.yaml
kubectl apply -f https://download.elastic.co/downloads/eck/$ELASTIC_VERSION/operator.yaml

echo -e "${Yel}Waiting for Elasticsearch k8s operator to be ready${RCol}"
while [[ $(kubectl get pods -l statefulset.kubernetes.io/pod-name=elastic-operator-0 -n elastic-system -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]] 
do echo -n "." && sleep 1
done
echo -e "\n${Gre}Elasticsearch k8s operator is ready${RCol}"
# Waiting for the operator to be ready
sleep 30

# Deploying Elasticsearch cluster
cat <<EOF | kubectl apply -f -
apiVersion: elasticsearch.k8s.elastic.co/v1
kind: Elasticsearch
metadata:
  name: quickstart
spec:
  version: 7.16.2
  nodeSets:
  - name: default
    count: 2
    config:
      node.store.allow_mmap: false
EOF

echo -e "${Yel}Waiting for Elasticsearch cluster to be ready${RCol}"
while [[ $(kubectl get pods -l statefulset.kubernetes.io/pod-name=quickstart-es-default-0 -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]] 
do echo -n "." && sleep 1
done
echo -e "\n${Gre}Elasticsearch cluster is ready${RCol}"

# Deploying kibana

cat <<EOF | kubectl apply -f -
apiVersion: kibana.k8s.elastic.co/v1
kind: Kibana
metadata:
  name: quickstart
spec:
  version: 7.16.2
  count: 2
  elasticsearchRef:
    name: quickstart
EOF

echo -e "${Yel}Waiting for Kibana to be ready${RCol}"
while [[ $(kubectl get pods -l kibana.k8s.elastic.co/name=quickstart -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True True" ]] 
do echo -n "." && sleep 1
done
echo -e "\n${Gre}Kibana is ready${RCol}"