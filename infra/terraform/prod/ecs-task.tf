resource "aws_ecs_task_definition" "task" {
  family                   = local.project_name
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/ecsTaskExecutionRole"
  cpu                      = "256"
  memory                   = "1024"
  container_definitions    = <<TASK_DEFINITION
[
    {
        "name": "${local.ecr.container_name.web}",
        "image": "${data.aws_caller_identity.current.account_id}.dkr.ecr.ap-northeast-1.amazonaws.com/${local.ecr.container_name.web}:1.0.0",
        "portMappings": [
            {
                "containerPort": 80,
                "protocol": "tcp"
            }
        ],
        "dependsOn": [
            {
                "containerName": "${local.ecr.container_name.app}",
                "condition": "START"
            }
        ],
        "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
                "awslogs-group": "/ecs/${local.ecr.container_name.web}",
                "awslogs-region": "ap-northeast-1",
                "awslogs-stream-prefix": "${local.ecr.container_name.web}"
            }
        }
    },
    {
        "name": "${local.ecr.container_name.app}",
        "image": "${data.aws_caller_identity.current.account_id}.dkr.ecr.ap-northeast-1.amazonaws.com/${local.ecr.container_name.app}:1.0.0",
        "essential": true,
        "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
                "awslogs-group": "/ecs/${local.ecr.container_name.app}",
                "awslogs-region": "ap-northeast-1",
                "awslogs-stream-prefix": "${local.ecr.container_name.app}"
            }
        }
    }
]
TASK_DEFINITION
}
