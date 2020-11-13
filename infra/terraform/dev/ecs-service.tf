resource "aws_ecs_service" "ecs" {
  name                               = local.project_name
  cluster                            = aws_ecs_cluster.main.id
  task_definition                    = "${aws_ecs_task_definition.task.family}:${aws_ecs_task_definition.task.revision}"
  desired_count                      = 1
  launch_type                        = "FARGATE"
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  platform_version                   = "LATEST"

  network_configuration {
    subnets          = local.network.subnet_ids
    security_groups  = local.network.security_groups
    assign_public_ip = true
  }

  health_check_grace_period_seconds = 0

  load_balancer {
    target_group_arn = aws_lb_target_group.lb_target_blue.arn
    container_name   = local.ecr.container_name.web
    container_port   = 80
  }

  scheduling_strategy = "REPLICA"

  deployment_controller {
    type = "CODE_DEPLOY"
  }

  lifecycle {
    ignore_changes = [
      platform_version,
      desired_count,
      task_definition,
      load_balancer,
    ]
  }
  propagate_tags = "TASK_DEFINITION"
}
