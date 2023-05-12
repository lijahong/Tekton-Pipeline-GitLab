#!/bin/bash

# delete auth
echo "---------------------------------------"
echo "-------Delete Task Start-------------0%"
echo "---------------------------------------"
echo "---------------------------------------"
echo "-------Start Delete All Auth--------30%"
echo "---------------------------------------"
kubectl delete -f auth/rbac/clusterole.yaml
kubectl delete -f auth/rbac/clusterrolebind.yaml
kubectl delete -f auth/auth-sa.yaml
kubectl delete -f auth/dockerhub/docker-config-se.yaml
kubectl delete -f auth/gitlab/git-ssl-se.yaml
kubectl delete -f auth/gitlab/gitlab-se.yaml
kubectl delete -f trigger/auth-trigger/role.yaml
kubectl delete -f trigger/auth-trigger/rolebinding.yaml
kubectl delete -f trigger/auth-trigger/sa-trigger.yaml

# delete task and pipeline
echo "---------------------------------------"
echo "-------Delete Task & Pipeline-------60%"
echo "---------------------------------------"
kubectl delete -f pipeline/pipeline.yaml
kubectl delete -f task/gitclone.yaml
kubectl delete -f task/kaniko.yaml
kubectl delete -f task/kubecommand.yaml

echo "---------------------------------------"
echo "-----------Delete Trigger-----------80%"
echo "---------------------------------------"
# delete trigger
kubectl delete -f trigger/trigerbinding.yaml
kubectl delete -f trigger/trigertemplate.yaml
kubectl delete -f trigger/eventlistener.yaml
kubectl delete -f trigger/ingress-trigger.yaml

# delete deploy and svc
echo "---------------------------------------"
echo "-----Delete Deployment and SVC------90%"
echo "---------------------------------------"
kubectl delete deploy -n hongspace tektontest
kubectl delete svc -n hongspace svc-lb-hong

echo "---------------------------------------"
echo "------Delete Task Complete---------100%"
echo "---------------------------------------"
