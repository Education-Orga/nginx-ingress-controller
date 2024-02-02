#!/bin/bash

# set context to application-cluster
KUBE_CONTEXT="kind-application-cluster"
kubectl config use-context "$KUBE_CONTEXT"

# create nginx-ingress and hr-system  namespace if not present
NGINX_NAMESPACE="nginx-ingress"
kubectl get ns "$NGINX_NAMESPACE" || kubectl create ns "$NGINX_NAMESPACE"

HR_SYSTEM_NAMESPACE="nginx-ingress"
kubectl get ns "$HR_SYSTEM_NAMESPACE" || kubectl create ns "$HR_SYSTEM_NAMESPACE"

# deploy nginx-ingress operator
cd cd nginx-ingress-helm-operator/

make deploy

# deploy resources
kubectl apply -f configs/nginx-ingress-manifest.yaml -n "$NGINX_NAMESPACE"
kubectl apply -f configs/hr-ingress.yaml -n "$HR_SYSTEM_NAMESPACE"

echo "Nginx Ingress Operator and CRDs deployed successfully in namespace '$NGINX_NAMESPACE' of context '$KUBE_CONTEXT'."