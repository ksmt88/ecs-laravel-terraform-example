resource "aws_ecs_cluster" "main" {
  name = local.ecs.cluster_name
}

resource "aws_cloudwatch_log_group" "ecs_log_group_web" {
  name = "/ecs/${local.ecr.container_name.web}"
}

resource "aws_cloudwatch_log_group" "ecs_log_group_app" {
  name = "/ecs/${local.ecr.container_name.app}"
}
