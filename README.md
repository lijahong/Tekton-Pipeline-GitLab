# Tekton-Pipeline-GitLab

---

## Project 설명

#### Tekton을 이용한 Pipeline 구축 & Trigger를 이용한 Pipeline 자동 실행 - GitLab 사용 버전
> #### [ 상세 내용 링크 ](https://velog.io/@lijahong/0%EB%B6%80%ED%84%B0-%EC%8B%9C%EC%9E%91%ED%95%98%EB%8A%94-TEKTON-%EA%B3%B5%EB%B6%80-CICD-Pipeline-%EA%B5%AC%EC%B6%95-GitLab-Private-Repo-Clone-With-TLS)

#### 사용 Repository
> - Code Repository : GitLab Private Repo
> - Image Repository : DockerHub Private Repo

#### Tekton을 이용한 CI / CD Pipeline 구축
> 1. GitLab Private Repo Clone
> 2. Kaniko를 이용하여 Docker Image Build & DockerHub Private Repo에 Push
> 3. Push한 Image를 이용하여 Deployment & Service를 Eks Cluster에 배포

#### Trigger를 이용한 Pipeline 자동 실행
> 1. Push Event 발생
> 2. WebHook을 통해 Json Payload가 EventListenr에게 전송
> 3. Trigger를 이용하여 Pipeline 실행

---

## 파일 설명

```shell
├── auth
│   ├── auth-sa.yaml
│   ├── dockerhub
│   │   └── docker-config-se.yaml
│   ├── gitlab
│   │   ├── git-ssl-se.yaml
│   │   ├── gitlab-se.yaml
│   │   └── gitlab-se.yaml.bak
│   └── rbac
│       ├── clusterole.yaml
│       └── clusterrolebind.yaml
├── authapply.sh
├── delete.sh
├── ingress-ttdashboard.yaml
├── pipeline
│   ├── pipeline.yaml
│   └── pipelineRun.yaml
├── setpipeline.sh
├── task
│   ├── gitclone.yaml
│   ├── kaniko.yaml
│   └── kubecommand.yaml
└── trigger
    ├── auth-trigger
    │   ├── role.yaml
    │   ├── rolebinding.yaml
    │   └── sa-trigger.yaml
    ├── eventlistener.yaml
    ├── ingress-trigger.yaml
    ├── trigerbinding.yaml
    └── trigertemplate.yaml
```
> - 전체 파일 구조는 위와 같다

#### Ingress
> - ingress-ttdashboard.yaml : Tekton DashBoard를 외부 노출하기 위한 Ingress 파일

#### 실행 Script
> - authapply.sh : Tekton Pipeline & Trigger를 위한 인증 정보 배포
> - setpipeline.sh : Tekton Pipeline & Trigger 배포
> - delete.sh : Tekton Pipeline & Trigger 삭제 및 배포한 Deployment & Service 삭제 

#### auth Directory : Tekton Pipeline 실행에 필요한 인증 & 권한 정보
> - auth-sa.yaml : Tekton Pipeline 실행에 사용할 ServiceAccount 파일
> - dockerhub/docker-config-se.yaml : DockerHub Private Repo 접근에 필요한 인증 정보를 담은 Secrets 파일. dockerconfig.json 정보를 입력해야 한다
> - gitlab/git-ssl-se.yaml : GitLab TLS 인증을 위한 Root CA 인증서 정보를 담은 Secrets 파일. Root CA 인증서 정보를 입력해야 한다
> - gitlab/gitlab-secret.yaml : GitLab Private Repo 접근에 필요한 인증 정보를 담은 Secrets 파일. GitLab Username과 AccessToken 정보를 입력해야 한다
> - rbac/clusterole.yaml : Kubernetes Cluster에 배포하기 위한 권한 정보를 담은 ClusterRole 파일
> - rbac/clusterrolebind.yaml : auth-sa와 clusterole을 Bind 하기 위한 ClusterRoleBinding 파일

#### pipeline Directory : Pipeline & PipelineRun 정보
> - pipeline/pipeline.yaml : 구축한 Pipeline 파일
> - pipeline/pipelineRun.yaml : Pipeline을 실행하기 위한 PipelineRun 파일. Trigger 구축 후에는 사용하지 않는다

#### task Directory : Task 정보
> - task/gitclone.yaml : Git Clone 하기 위한 Task 파일
> - task/kaniko.yaml : Image Build & Push 하기 위한 Task 파일
> - task/kubecommand.yaml : Kubernetes Cluster에 배포하기 위한 파일

#### trigger Directory : Trigger 정보
> - trigger/auth-trigger/role.yaml : EventListener Pod를 실행하기 위한 권한 정보를 담은 role & ClusterRole 파일
> - trigger/auth-trigger/rolebinding.yaml : role과 sa-trigger를 Bind 하기 위한 RoleBinding & ClusterRoleBinding 파일
> - trigger/auth-trigger/sa-trigger.yaml : EventListener Pod를 실행하기 위한 ServiceAccount 파일
> - trigger/eventlistener.yaml : 외부에서 Event를 받아 Trigger를 작동시키는 EventListener 파일
> - trigger/trigerbinding.yaml : Event Data ( Json Payload )와 TriggerTemplate의 파라미터를 매핑하기 위한 TriggerBinding 파일
> - trigger/trigertemplate.yaml : 넘겨 받은 파라미터를 이용해 어떤 Pipeline을 실행시킬건지 정의한 TriggerTemplate 파일
> - trigger/ingress-trigger.yaml : EventListener를 외부에 노출하기 위한 Ingress 파일
