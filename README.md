ECS laravel sample
====

- application: laravel  
- test: circleci
- server: ecs(FARGATE)
- deploy: aws code pipeline(blue green deploy)

## How to use
Set personal access token.
```bash
export TF_VAR_github_token=xxxx
```
Modify variable.tf
```bash
cd infra/terraform/dev
vi variable.tf
```
Execute terraform.
```bash
terraform init
terraform apply
```
Service registration will fail because there is no Image.
Modify NAME in initialImagePush.sh
```bash
cd ../../../
vi initialImagePush.sh
```
Push Image to ecr.
```bash
./initialImagePush.sh
```
Re-execute terraform.
```bash
cd infra/terraform/dev
terraform apply
```
