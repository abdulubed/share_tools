provider "aws" {
  region          = var.region
  assume_role {
    role_arn      = "arn:aws:iam::${var.account}:role/Jenkins-Role"
  }
}

## validate-mtd Lambda Execution Role, Policy, and Policy Attachment ##
resource "aws_iam_role" "iam_role_validate_mtd" {
  name = var.validate_mtd_lambda_exec_role

  tags = {
    Name        = var.validate_mtd_lambda_exec_role
    Environment = var.environment
    map-migrated= var.map-migrated-server-id
  }
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
        {
            Effect = "Allow",
            Principal = {
                Service = [
                    "apigateway.amazonaws.com",
                    "lambda.amazonaws.com"
                ]
            },
            Action = "sts:AssumeRole"
        },
        {
            Effect = "Allow",
            Principal = {
                Service = [
                    "apigateway.amazonaws.com",
                    "lambda.amazonaws.com"
                ],
                  AWS = var.aws_user_snowflake
            },
            Action = "sts:AssumeRole",
            Condition = {
                  StringEquals = {
                    "sts:ExternalId": var.aws_iam_snowflake_user_id
                }
            }
        }
    ]
  })
}

resource "aws_iam_policy" "validate_mtd_lambda_exec_policy" {
  name   = var.validate_mtd_lambda_exec_policy
  tags = {
    Name        = var.validate_mtd_lambda_exec_policy
    Environment = var.environment
    map-migrated= var.map-migrated-server-id
  }
  policy = jsonencode({
        Version = "2012-10-17",
    Statement = [
        {
            Sid = "VisualEditor0",
            Effect = "Allow",
            Action = [
                "lambda:InvokeFunction",
                "lambda:InvokeAsync"
            ],
            Resource = "*"
        },
        {
            Sid = "VisualEditor1",
            Effect = "Allow",
            Action = [
                "secretsmanager:GetResourcePolicy",
                "secretsmanager:GetSecretValue",
                "secretsmanager:DescribeSecret",
                "secretsmanager:ListSecretVersionIds"
            ],
            Resource = [
                "arn:aws:secretsmanager:${var.region}:${var.account}:secret:${var.server1_secret}",
                "arn:aws:secretsmanager:${var.region}:${var.account}:secret:${var.server2_secret}",
                "arn:aws:secretsmanager:${var.region}:${var.account}:secret:${var.snowflake}"
            ]
        }
    ]
  })
}

# Then parse through the list using count
resource "aws_iam_role_policy_attachment" "role-policy-attachment" {
  role        = aws_iam_role.iam_role_validate_mtd.name
  count      = "${length(var.iam_policy_arn)}"
  policy_arn = "${var.iam_policy_arn[count.index]}"
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment_secret_manager" {
  role        = aws_iam_role.iam_role_validate_mtd.name
  policy_arn  = aws_iam_policy.validate_mtd_lambda_exec_policy.arn
}