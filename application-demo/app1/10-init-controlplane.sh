######################
# Add Control Plane
######################

oc project ${MY_SM_SMCP}

oc apply -f -<<EOF

apiVersion: maistra.io/v2
kind: ServiceMeshControlPlane
metadata:
 namespace: ${MY_SM_SMCP}
 name: basic
spec:
spec:
 tracing:
   sampling: 10000
   type: Jaeger
 gateways:
   openshiftRoute:
     enabled: false
 policy:
   type: Istiod
 addons:
   grafana:
     enabled: true
   jaeger:
     install:
       storage:
         type: Memory
   kiali:
     enabled: true
   prometheus:
     enabled: true
 version: v2.0
 telemetry:
   type: Istiod

EOF

######################
# Add MemberRoll
######################


export MY_SM_APP=mgen-servicemesh-app1
oc new-project ${MY_SM_APP}

oc apply -f -<<EOF

apiVersion: maistra.io/v1
kind: ServiceMeshMemberRoll
metadata:
  name: default
  namespace: ${MY_SM_SMCP}
spec:
  members:
    - ${MY_SM_APP}

EOF



