resource "aws_s3_bucket" "artifact" {
  bucket = "${local.project_name}-artifact"
  acl    = "private"

  versioning {
    enabled = true
  }
}
