locals {
  env          = "dev"
  project_name = "laravel-${local.env}"

  ecr = {
    container_name = {
      web = "${local.project_name}-web",
      app = "${local.project_name}-app",
    }
  }

  network = {
    vpc_id = "vpc-xxxxxxxx"
    subnet_ids = [
      "subnet-xxxxxxxx",
      "subnet-xxxxxxxx",
    ]
    security_groups = [
      "sg-xxxxxxxx",
    ]
  }

  ecs = {
    cluster_name = local.project_name
  }

  code_pipeline = {
    role_name = "codepipeline-${local.project_name}-service-role"
    source = {
      owner          = "ksmt88"
      repo           = "ecs-laravel-terraform-example"
      branch         = "develop"
      token          = var.github_token
      webhook_secret = "secret"
    }
  }

  code_build = {
    role_name = "codebuild-${local.project_name}-service-role"
  }

  code_deploy = {
    role_name = "codedeploy-${local.project_name}-service-role"
  }
}

variable "github_token" {
  type = string
}

data "aws_caller_identity" "current" {}
