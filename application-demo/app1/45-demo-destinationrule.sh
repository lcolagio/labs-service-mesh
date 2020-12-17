############################
# VS 
############################

oc delete virtualservice customer

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
    - match:
        - uri:
            exact: /customer
      rewrite:
        uri: /
      route:
        - destination:
            host: customer
            port:
              number: 8080
    - match:
        - uri:
            exact: /recommendation
      rewrite:
        uri: /
      route:
        - destination:
            host: recommendation
            subset: v1
          weight: 80
        - destination:
            host: recommendation
            subset: v2
          weight: 20
---

kind: DestinationRule
apiVersion: networking.istio.io/v1alpha3
metadata:
  name: recommendation
  namespace: ${MY_SM_APP}
spec:
  host: recommendation
  subsets:
    - labels:
        version: v1
      name: v1
    - labels:
        version: v2
      name: v2
    - labels:
        version: v3
      name: v3

EOF



