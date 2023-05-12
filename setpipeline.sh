#!/bin/sh

echo "---------------------------------------"
echo "--------Starting Pipeline...---------0%"
echo "---------------------------------------"

echo "---------------------------------------"
echo "-------Deploy git clone Task---------20%"
echo "---------------------------------------"
# deploy task - git clone
kubectl apply -f task/gitclone.yaml

echo "---------------------------------------"
echo "--Deploy Image build & push Task----40%"
echo "---------------------------------------"
# deploy task - image build & push
kubectl apply -f task/kaniko.yaml

echo "---------------------------------------"
echo "-------Deploy Kubecommand Task------60%"
echo "---------------------------------------"
# deploy taks - kubernetes deploy
kubectl apply -f task/kubecommand.yaml

echo "---------------------------------------"
echo "------------Deploy Pipeline---------80%"
echo "---------------------------------------"
# deploy pipeline
kubectl apply -f pipeline/pipeline.yaml

echo "---------------------------------------"
echo "------------Deploy Trigger----------90%"
echo "---------------------------------------"
# deploy trigger
kubectl apply -f trigger/trigerbinding.yaml
kubectl apply -f trigger/trigertemplate.yaml
kubectl apply -f trigger/eventlistener.yaml
kubectl apply -f trigger/ingress-trigger.yaml

echo "---------------------------------------"
echo "-------Watch Dashboard for 100%--------"
echo "---------------------------------------"
