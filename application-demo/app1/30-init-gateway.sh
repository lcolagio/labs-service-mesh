oc apply -f -<<EOF

kind: Route
apiVersion: route.openshift.io/v1
metadata:
  name: ${MY_SM_APP}
  namespace: ${MY_SM_SMCP}
spec:
  to:
    kind: Service
    name: istio-ingressgateway
    weight: 100
  port:
    targetPort: 8080
  wildcardPolicy: None

EOF

oc apply -f -<<EOF

kind: Gateway
apiVersion: networking.istio.io/v1alpha3
metadata:
  name: customer-gateway
  namespace: ${MY_SM_APP}
spec:
  servers:
    - hosts:
        - ${MY_SM_APP}-${MY_SM_SMCP}.${SUBDOMAIN}
      port:
        name: http
        number: 80
        protocol: HTTP
  selector:
    istio: ingressgateway

EOF
