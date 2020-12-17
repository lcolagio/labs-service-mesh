export MY_SM_SMCP=mgen-servicemesh-cp
export MY_SM_APP=mgen-servicemesh-app1
export SUBDOMAIN=$(oc get ingresses.config.openshift.io cluster -o jsonpath='{.spec.domain}')

echo $MY_SM_SMCP
echo $MY_SM_APP
echo $SUBDOMAIN

