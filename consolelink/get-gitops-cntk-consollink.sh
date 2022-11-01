### Setting Argo UI URL and the secret will be echo-ed in your terminal
ARGOURL=$(oc get route -n openshift-gitops | grep openshift-gitops-cntk-server | awk '{print "https://"$2}')
ARGO_SECRET=$(oc get secret/openshift-gitops-cntk-cluster -n openshift-gitops -o json | jq -r '.data."admin.password"' | base64 -D)

( echo "cat <<EOF" ; cat argocd-consolelink.yaml_template;) | \
ARGOURL=${ARGOURL} \
sh > openshift-gitops-cntk.yaml
echo ${ARGOURL}
echo ${ARGO_SECRET}

### Setting Git Org console link required to set GIT_ORG
if [ -z ${GIT_ORG} ]; then echo "Please set GIT_ORG when running script, optional GIT_BASEURL and GIT_REPO to formed the git url GIT_BASEURL/GIT_ORG/*"; exit 1; fi

set -u
GIT_BASEURL=${GIT_BASEURL:-https://github.com}
( echo "cat <<EOF" ; cat git-org-consolelink.yaml_template;) | \
GIT_BASEURL=${GIT_BASEURL} \
sh > git-org-consolelink.yaml
echo ${GIT_BASEURL}/${GIT_ORG}