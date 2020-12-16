############################
# VS
############################

oc delete VirtualService customer

oc apply -f -<<EOF

kind: VirtualService
apiVersion: networking.istio.io/v1alpha3
metadata:
  name: customer
  namespace: ${MY_SM_APP}
spec:
  hosts:
    - ${MY_SM_APP}-${MY_SM_SMCP}.${SUBDOMAIN}
  gateways:
    - ${MY_SM_APP}/customer-gateway
  http:
    -  route:
        - destination:
            host: customer
            port:
              number: 8080
EOF

