#!/bin/bash

echo "---------------------------------------"
echo "----start apply auth for tekton...---0%"
echo "---------------------------------------"

# secret for dockerhub auth - private repo
echo "---------------------------------------"
echo "-------------dockerhub auth---------20%"
echo "---------------------------------------"
kubectl apply -f auth/dockerhub/docker-config-se.yaml

# secret for github auth - private repo
echo "---------------------------------------"
echo "-------------github auth------------30%"
echo "---------------------------------------"
kubectl apply -f auth/gitlab/git-ssl-se.yaml
kubectl apply -f auth/gitlab/gitlab-se.yaml

# cluster role for kubectl SA
echo "---------------------------------------"
echo "-------------cluster role-----------40%"
echo "---------------------------------------"
kubectl apply -f auth/rbac/clusterole.yaml

# cluster role binding for kubectl SA
echo "---------------------------------------"
echo "--------cluster role binding--------50%"
echo "---------------------------------------"
kubectl apply -f auth/rbac/clusterrolebind.yaml

# SA for Tekton PipelineRun
echo "---------------------------------------"
echo "-------------Service Account--------60%"
echo "---------------------------------------"
kubectl apply -f auth/auth-sa.yaml

# SA, RBAC for Tekton Trigger
echo "---------------------------------------"
echo "--------Trigger RBAC SETTING--------80%"
echo "---------------------------------------"
kubectl apply -f trigger/auth-trigger/role.yaml
kubectl apply -f trigger/auth-trigger/rolebinding.yaml
kubectl apply -f trigger/auth-trigger/sa-trigger.yaml

echo "---------------------------------------"
echo "----------ALL COMPLETE-------------100%"
echo "---------------------------------------"
