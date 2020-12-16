export MY_SM_SMCP=mgen-servicemesh-cp
export MY_SM_APP=mgen-servicemesh-app-1
export SUBDOMAIN=$(oc get ingresses.config.openshift.io cluster -o jsonpath='{.spec.domain}')
