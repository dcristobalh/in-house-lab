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

echo -e "${BIBlu}-----------------------------------------------------------${RCol}"
echo -e "${BIBlu}-------------------------OVERVIEW--------------------------${RCol}"
echo -e "${BIBlu}-----------------------------------------------------------${RCol}"
echo -e ""
echo -e "${On_Pur}--------------------------ELK-----------------------------${RCol}"
echo -e "${BIRed}You can access kibana using port forwarding${RCol}"
echo -e "${IWhi}kubectl port-forward service/quickstart-kb-http 5601${RCol}"
echo -e "${BIRed}And you can login to kibana using the following URL${RCol}"
echo -e "${IWhi}https://localhost:5601${RCol}"
echo -e "${BIRed}You can access with elastic user and password with this command${RCol}"
echo -e "${IWhi}kubectl get secret quickstart-es-elastic-user -o=jsonpath='{.data.elastic}' | base64 --decode; echo${RCol}"
echo -e ""
echo -e "${On_Pur}-------------------------TEKTON----------------------------${RCol}"
echo -e "${BIRed}You can access tekton dashboard using port forwarding${RCol}"
echo -e "${IWhi}kubectl --namespace tekton-pipelines port-forward svc/tekton-dashboard 9097:9097${RCol}"
echo -e "${BIRed}And you can see url in...${RCol}"
echo -e "${IWhi}https://localhost:9097${RCol}"
echo -e ""
echo -e "${On_Pur}------------------------CERT-MANAGER------------------------${RCol}"
echo -e "${BIRed}Cert-manager operator is installed, now you can apply issuers ;)${RCol}"
echo -e ""
echo -e "${On_Pur}--------------------KUBERNETES-DASHBOARD---------------------${RCol}"
echo -e "${BIRed}You can access kubernetes dashboard using port forwarding${RCol}"
echo -e "${IWhi}kubectl proxy${RCol}"
echo -e "${BIRed}And you can see url in...${RCol}"
echo -e "${IWhi}http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/${RCol}"
echo -e "${BIRed}You can access with this token...${RCol}"
export token=$(kubectl get secret | grep cluster-admin-dashboard-sa | awk '{print $1}') > /dev/null 2>&1
kubectl get secret $token -o=jsonpath='{.data.token}' | base64 --decode; echo