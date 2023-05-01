# Google Kubernetes Engine Management


# Launch Instructions

1. Set environment variables

```bash
export PROJECT_ID=audio-streaming-data-platform
export GKE_KAFKA_NAMESPACE=kafka
```

2. Provision a GKE cluster with Terraform

Update variables in terraform/terraform.tfvars and run commands below:
```bash
terraform -chdir=terraform init
terraform -chdir=terraform apply
```
<i>*wait for a few minutes</i>

Example of successed provisioning:

```bash
Apply complete! Resources: 4 added, 0 changed, 0 destroyed.
Outputs:
kubernetes_cluster_host = "<Your Cluster IP>"
kubernetes_cluster_name = "<PROJECT_ID>-gke"
project_id = "<PROJECT_ID>"
region = "<REGION from terraform.tfvars>"
zone = "<ZONE from terraform.tfvars>"
```

3. Configure kubectl

```bash
gcloud container clusters get-credentials \
  $(terraform -chdir=terraform output -raw kubernetes_cluster_name) \
  --region $(terraform -chdir=terraform output -raw zone)
```

4. Create namespace

```bash
kubectl create namespace $GKE_KAFKA_NAMESPACE
```

5. Deploy Kafka on the Kubernetes cluster

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami

# Deploy with external IP access
helm -n $GKE_KAFKA_NAMESPACE upgrade --install kafka bitnami/kafka \
 --set externalAccess.enabled=true \
 --set externalAccess.service.type=LoadBalancer \
 --set externalAccess.service.ports.external=9094 \
 --set externalAccess.autoDiscovery.enabled=true \
 --set serviceAccount.create=true \
 --set rbac.create=true

# Deploy with access from internal network
helm -n $GKE_KAFKA_NAMESPACE upgrade --install kafka bitnami/kafka \
 --set externalAccess.enabled=true \
 --set externalAccess.service.type=NodePort \
 --set externalAccess.autoDiscovery.enabled=true \
 --set serviceAccount.create=true \
 --set rbac.create=true

 gcloud compute firewall-rules create kafka-node-port --allow tcp:9094

```

Check deployed services:
```bash
kubectl get all -n $GKE_KAFKA_NAMESPACE
```

If deploy is successful you will see the output like this:
```bash
NAME          READY   STATUS    RESTARTS   AGE
pod/kafka-0   1/1     Running   0          53s

NAME                       TYPE           CLUSTER-IP       EXTERNAL-IP      PORT(S)                      AGE
service/kafka              ClusterIP      <Internal IP>    <none>           9092/TCP,9095/TCP            39m
service/kafka-0-external   LoadBalancer   <Internal IP>    <EXTERNAL IP>    9094:31852/TCP               39m
service/kafka-headless     ClusterIP      None             <none>           9092/TCP,9094/TCP,9093/TCP   39m

NAME                     READY   AGE
statefulset.apps/kafka   1/1     39m
```

You can use external IP to connect to the Kafka brokers.

6. Test Kafka

Test producing messages to Kafka:
```bash
kafka-console-producer.sh \
      --broker-list <LoadBalancer External IP>:9094 \
      --topic test
```

Test consuming messages from Kafka:
```bash
kafka-console-consumer.sh \
      --bootstrap-server <LoadBalancer External IP>:9094 \
      --topic test \
      --from-beginning
```

7. Clean Up

```bash
# Uninstall Kafka release
helm uninstall kafka -n $GKE_KAFKA_NAMESPACE

# Destroy provisioned resources 
terraform -chdir=terraform destroy
```


