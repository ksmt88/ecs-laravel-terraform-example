resource "aws_ecr_repository" "web" {
  name                 = local.ecr.container_name.web
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "app" {
  name                 = local.ecr.container_name.app
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}
