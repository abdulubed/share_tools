### secret rotation Lambda Execution Role, Policy, and Policy Attachment ###
resource "aws_iam_role" "iam_role_rotation" {
  name = var.secret_rotation_lambda_exec_role

  tags = {
    Name        = var.secret_rotation_lambda_exec_role
    Environment = var.environment
    map-migrated= var.map-migrated-server-id
  }

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = ["lambda.amazonaws.com"
                ]
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment_rotation" {
  role        = aws_iam_role.iam_role_rotation.name
  policy_arn  = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role" "iam_role_assume" {
  name = var.assume_exec_role
  assume_role_policy = jsonencode({
   "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${var.daas_account_number}:role/czr-daas-${var.environment}-snowflake-lambda-service-role"
            },
            "Action": "sts:AssumeRole"
        }
    ]
})
  tags = {
    Name                   = "czr-raas-iam-${var.environment}-${var.application}-role"
    Environment            = var.environment
    map-migrated           = var.map-migrated-server-id
  }
}

#Create the iam policy for  msk access
resource "aws_iam_policy" "msk_policy" {
  name = var.policy_name_msk
  description = "used to connect MSK"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "kafka-cluster:Connect",
                "kafka-cluster:AlterCluster",
                "kafka-cluster:DescribeCluster"
            ],
            "Resource": [
                "arn:aws:kafka:${var.region}:${var.account}:cluster/${var.cluster_name}/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "kafka-cluster:*Topic*",
                "kafka-cluster:WriteData",
                "kafka-cluster:ReadData"
            ],
            "Resource": [
                "arn:aws:kafka:${var.region}:${var.account}:topic/${var.cluster_name}/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "kafka-cluster:AlterGroup",
                "kafka-cluster:DescribeGroup"
            ],
            "Resource": [
                "arn:aws:kafka:${var.region}:${var.account}:group/${var.cluster_name}/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                 "kafka:DescribeCluster"
            ],
            "Resource": [
                "arn:aws:kafka:${var.region}:${var.account}:cluster/${var.cluster_name}/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "kafka:GetBootstrapBrokers"
            ],
            "Resource": [
                "arn:aws:kafka:${var.region}:${var.account}:cluster/${var.cluster_name}/*"
            ]
        }
    ]
}
EOF
}

#Create the iam policy for  kms & secrets access
resource "aws_iam_policy" "msk_policy_kms" {
  name        = var.policy_name_kms_secrets
  description = "used for secrets"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "secretsmanager:DescribeSecret",
                "secretsmanager:GetSecretValue",
                "secretsmanager:PutSecretValue",
                "secretsmanager:UpdateSecretVersionStage",
                "secretsmanager:UpdateSecret"
            ],
            "Resource": [
                "${aws_secretsmanager_secret.secrets_msk_secret.arn}"
            ]
        },
        {
            "Effect": "Allow",
             "Action": [
             "kms:Encrypt",
             "kms:Decrypt",
             "kms:ReEncrypt*",
             "kms:GenerateDataKey*",
             "kms:DescribeKey"
            ],
            "Resource": [
                "${aws_kms_key.kms_key.arn}"
            ]
        }
    ]
}
EOF
 depends_on = [
    aws_secretsmanager_secret.secrets_msk_secret,
    aws_kms_key.kms_key,
    aws_iam_role.iam_role_assume
  ]
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment_SSMManged" {
  role        = aws_iam_role.iam_role_assume.name
  policy_arn  = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment_msk" {
  role        = aws_iam_role.iam_role_assume.name
  policy_arn  = aws_iam_policy.msk_policy.arn
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment_msk_kms" {
  role        = aws_iam_role.iam_role_assume.name
  policy_arn  = aws_iam_policy.msk_policy_kms.arn
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment_lambda_secret_rotation" {
  role        = aws_iam_role.iam_role_rotation.name
  policy_arn  = aws_iam_policy.msk_policy_kms.arn
}