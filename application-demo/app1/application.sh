export MY_SM_SMCP=mgen-servicemesh
export MY_SM_APP=mgen-servicemesh-app1
export SUBDOMAIN=$(oc get ingresses.config.openshift.io cluster -o jsonpath='{.spec.domain}')

oc project ${MY_SM_APP}

oc apply -f -<<EOF

apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: curl
    version: v1
  name: curl
spec:
  replicas: 1
  selector:
    matchLabels:
      app: curl
      version: v1
  template:
    metadata:
      labels:
        app: curl
        version: v1
      annotations:
        sidecar.istio.io/inject: "false"
    spec:
      containers:
      - image: quay.io/maistra_demos/curl:latest
        command: ["/bin/sleep", "3650d"]
        imagePullPolicy: Always
        name: curl

EOF

oc apply -f -<<EOF

apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: customer
    version: v1
  name: customer-v1
spec:
  replicas: 1
  selector:
    matchLabels:
      app: customer
      version: v1
  template:
    metadata:
      labels:
        app: customer
        version: v1
      annotations:
        sidecar.istio.io/inject: "true"
    spec:
      containers:
      - env:
        - name: JAVA_OPTIONS
          value: -Xms128m -Xmx256m -Djava.net.preferIPv4Stack=true -Djava.security.egd=file:///dev/./urandom
        image: quay.io/maistra_demos/customer:v1
        imagePullPolicy: Always
        name: customer
        ports:
        - containerPort: 8080
          name: http
          protocol: TCP
---
apiVersion: v1
kind: Service
metadata:
  name: customer
  labels:
    app: customer    
spec:
  ports:
  - name: http
    port: 8080
  selector:
    app: customer

EOF

oc apply -f -<<EOF

apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: preference
    version: v1
  name: preference-v1
spec:
  replicas: 1
  selector:
    matchLabels:
      app: preference
      version: v1
  template:
    metadata:
      labels:
        app: preference
        version: v1
      annotations:
        sidecar.istio.io/inject: "true"
    spec:
      containers:
      - env:
        - name: JAVA_OPTIONS
          value: -Xms128m -Xmx256m -Djava.net.preferIPv4Stack=true -Djava.security.egd=file:///dev/./urandom
        image: quay.io/maistra_demos/preference:v1
        imagePullPolicy: Always
        name: preference
        ports:
        - containerPort: 8080
          name: http
          protocol: TCP
---
apiVersion: v1
kind: Service
metadata:
  name: preference
  labels:
    app: preference    
spec:
  ports:
  - name: http
    port: 8080
  selector:
    app: preference

EOF

oc apply -f -<<EOF

apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: recommendation
    version: v1
  name: recommendation-v1
spec:
  replicas: 1
  selector:
    matchLabels:
      app: recommendation
      version: v1
  template:
    metadata:
      labels:
        app: recommendation
        version: v1
      annotations:
        sidecar.istio.io/inject: "true"
    spec:
      containers:
      - env:
        - name: JAVA_OPTIONS
          value: -Xmx256m
        image: quay.io/maistra_demos/recommendation:v1
        imagePullPolicy: Always
        name: recommendation
        ports:
        - containerPort: 8080
          name: http
          protocol: TCP
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: recommendation
    version: v2
  name: recommendation-v2
spec:
  replicas: 1
  selector:
    matchLabels:
      app: recommendation
      version: v2
  template:
    metadata:
      labels:
        app: recommendation
        version: v2
      annotations:
        sidecar.istio.io/inject: "true"
    spec:
      containers:
      - env:
        - name: JAVA_OPTIONS
          value: -Xmx256m
        image: quay.io/maistra_demos/recommendation:v2
        imagePullPolicy: Always
        name: recommendation
        ports:
        - containerPort: 8080
          name: http
          protocol: TCP
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: recommendation
    version: v3
  name: recommendation-v3
spec:
  replicas: 1
  selector:
    matchLabels:
      app: recommendation
      version: v3
  template:
    metadata:
      labels:
        app: recommendation
        version: v3
      annotations:
        sidecar.istio.io/inject: "true"
    spec:
      containers:
      - env:
        - name: JAVA_OPTIONS
          value: -Xmx256m
        image: quay.io/maistra_demos/recommendation:v3
        imagePullPolicy: Always
        name: recommendation
        ports:
        - containerPort: 8080
          name: http
          protocol: TCP
---
apiVersion: v1
kind: Service
metadata:
  name: recommendation
  labels:
    app: recommendation    
spec:
  ports:
  - name: http
    port: 8080
  selector:
    app: recommendation

EOF







