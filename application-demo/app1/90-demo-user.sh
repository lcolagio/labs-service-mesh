
export MY_SM_SMCP=mgen-servicemesh-cp
export MY_SM_APP=mgen-servicemesh-app-1
export SUBDOMAIN=$(oc get ingresses.config.openshift.io cluster -o jsonpath='{.spec.domain}')
export MY_SM_APP_ROUTE=$(oc get route ${MY_SM_APP} -n ${MY_SM_SMCP} -o 'jsonpath={.spec.host}')

#
# from external route
#
while true; do curl ${MY_SM_APP_ROUTE}; sleep 1; done
while true; do curl ${MY_SM_APP_ROUTE}/customer; sleep 1; done
while true; do curl ${MY_SM_APP_ROUTE}/recommendation; sleep 1; done

#
# from curl pod
#
oc rsh $(oc get pods -l app=curl --no-headers | awk '{print $1}') curl preference:8080
