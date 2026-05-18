# Задание 2. Интеграция с CI/CD и удалённым хранением состояния

## Удаленное хранение состояния

S3-backend для Terraform я настроил еще в задании 1, здесь повторяю код.

```terraform
terraform {
  required_version = ">= 1.1.6"
  
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.87.0"
    }
  }

  backend "s3" {
    endpoint                    = "storage.yandexcloud.net"
    bucket                      = "test-s3-dev-tfstate"
    region                      = "ru-central1-a"
    key                         = "terraform/test-dev.tfstate"
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
```
> [!NOTE]
> Имя бакета должно быть уникально в пределах всего облака Yandex Cloud.

## Интеграция с CI/CD 

Использую:

1. CI/CD: GitLab CI
2. [Downstream pipelines](https://docs.gitlab.com/ci/pipelines/downstream_pipelines/) с дочерними пайплайнами для каждого окружения.
```yaml
stages:
   - modules

variables:
  TF_STATE_NAME: default
  TF_CACHE_KEY: default
   
dev_env:
   stage: modules
   trigger:
      include:
         - local: "/.gitlab-ci/.dev.yml"
      strategy: depend
   only:
      changes:
         - /envs/dev/*
...
```

3. Terraform gitlab template:

```yaml
include:
  - template: Terraform.latest.gitlab-ci.yml

variables:
  TF_ROOT: "envs/dev"

...

deploy:
  environment:
    name: $TF_STATE_NAME
    action: start
    on_stop: destroy

destroy:
  extends: .terraform:destroy
  environment:
    name: $TF_STATE_NAME
    action: stop    
```

4. Авторизация в облаке через ключ IAM key, который передается как переменная пайплайна, сохраняется во временный файл:
```yaml
before_script:
...
  - echo "$YC_IAM_KEY" > ~/key.json
```
и подбирается Terraform-провайдером:
```terraform
provider "yandex" {
  service_account_key_file = "${file("~/key.json")}"
...
```

референс с другого курса по Kubernetes https://gitlab.com/voitenkov/microservices-demo/-/blob/kubernetes-gitops/.gitlab-ci.yml?ref_type=heads
