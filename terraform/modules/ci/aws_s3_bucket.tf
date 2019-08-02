resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket_prefix = "${var.aws_resource_base_name}codepipeline"
  acl           = "private"
  force_destroy = true
  tags = "${merge(
    local.common_tags,
    "${var.tags}"
  )}"
}
