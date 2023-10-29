````
configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: vault-config
  namespace: vault
data:
  config.hcl: |
    storage "file" {
      path = "/vault/data"
    }
    listener "tcp" {
      address = "0.0.0.0:8200"
      tls_disable = 1
    }
```

```
deployment.yaml

apiVersion: apps/v1
kind: Deployment
metadata:
  name: vault
  namespace: vault
spec:
  replicas: 1
  selector:
    matchLabels:
      app: vault
  template:
    metadata:
      labels:
        app: vault
    spec:
      containers:
      - name: vault
        image: vault:latest # Use the appropriate Vault image
        ports:
        - containerPort: 8200
        args:
        - server
        - -config=/vault/config/config.hcl
        volumeMounts:
        - name: vault-config
          mountPath: /vault/config
        - name: vault-data
          mountPath: /vault/data
      volumes:
      - name: vault-config
        configMap:
          name: vault-config
      - name: vault-data
        hostPath:
          path: /mnt/data
```
```
service.yaml

apiVersion: v1
kind: Service
metadata:
  name: vault
  namespace: vault
spec:
  selector:
    app: vault
  ports:
    - protocol: TCP
      port: 8200
      targetPort: 8200
  type: NodePort
```
