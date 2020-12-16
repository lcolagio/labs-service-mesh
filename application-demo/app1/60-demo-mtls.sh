########################
# PeerAuthentication STRICT
########################

oc delete PeerAuthentication mtls-only-policy

oc create -f -<<EOF

apiVersion: "security.istio.io/v1beta1"
kind: "PeerAuthentication"
metadata:
 name: mtls-only-policy
spec:
 mtls:
   mode: STRICT

EOF

########################
# PeerAuthentication DISABLE
########################

oc delete PeerAuthentication mtls-only-policy

oc create -f -<<EOF

apiVersion: "security.istio.io/v1beta1"
kind: "PeerAuthentication"
metadata:
 name: mtls-only-policy
spec:
 mtls:
   mode: DISABLE

EOF
