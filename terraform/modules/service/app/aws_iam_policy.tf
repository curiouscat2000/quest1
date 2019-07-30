resource "aws_iam_policy" "aws_service_discovery" {
  name        = "${var.aws_resource_base_name}_AllowAWSServiceDiscovery"
  description = "let use cloudmap"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "discovery:*",
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_policy" "aws_secrets_manager_read" {
  name        = "${var.aws_resource_base_name}_SecretsManagerReadSecrets"
  description = "read secrets from AWS"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "secretsmanager:GetRandomPassword",
                "secretsmanager:GetResourcePolicy",
                "secretsmanager:GetSecretValue",
                "secretsmanager:DescribeSecret",
                "secretsmanager:ListSecrets",
                "secretsmanager:ListSecretVersionIds"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}