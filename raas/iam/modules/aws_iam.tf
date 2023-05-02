provider "aws" {
  region          = var.region
  assume_role {
    role_arn      = "arn:aws:iam::${var.account}:role/Jenkins-Role"
  }
}

#Create the iam role for  vpc logflows
resource "aws_iam_role" "vpc_flow_log" {
  name = var.role_name_flowlog

  tags = {
    Name          = var.role_name_flowlog
    Environment   = var.environment
    map-migrated  = var.map-migrated-server-id
  }

  lifecycle {
    create_before_destroy = false
  }
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

#Create the iam policy for  vpc logflows
resource "aws_iam_role_policy" "vpc_log_policy" {
  name = var.policy_name_flowlog
  role = aws_iam_role.vpc_flow_log.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

# Existing role in AWS account 
data "aws_iam_role" "eks_role" {
  name = var.existing_eks_cluster_role
}

resource "aws_iam_role_policy" "eks_cluster_policy" {
  name  = var.eks_cluster_policy
  role  = data.aws_iam_role.eks_role.id

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
                "arn:aws:secretsmanager:${var.region}:${var.account}:secret:${var.jwt_secret}",
                "arn:aws:secretsmanager:${var.region}:${var.account}:secret:${var.database_secret}",
                "arn:aws:secretsmanager:${var.region}:${var.account}:secret:${var.database_secret_raas_offers}",
                "arn:aws:secretsmanager:${var.region}:${var.account}:secret:${var.strikeiron_secret}",
                "arn:aws:secretsmanager:${var.region}:${var.account}:secret:${var.em1_secret}",
                "arn:aws:secretsmanager:${var.region}:${var.account}:secret:${var.gms_secret}",
                "arn:aws:secretsmanager:${var.region}:${var.account}:secret:${var.gms_guest_secret}",
                "arn:aws:secretsmanager:${var.region}:${var.account}:secret:${var.pdb_republish_secret}",
                "arn:aws:secretsmanager:${var.region}:${var.account}:secret:${var.kafka_secret}",
                "arn:aws:secretsmanager:${var.region}:${var.account}:secret:${var.security_questions_limit}",
                "arn:aws:secretsmanager:${var.region}:${var.account}:secret:${var.lambda_enc_secret}",
                "arn:aws:secretsmanager:${var.region}:${var.account}:secret:${var.gms_get_rg_secret}",
                "arn:aws:secretsmanager:${var.region}:${var.account}:secret:${var.sms_secret}",
                "arn:aws:secretsmanager:${var.region}:${var.account}:secret:${var.crypto_Secret}",
                "arn:aws:secretsmanager:${var.region}:${var.account}:secret:${var.tenable_audit}",
                "arn:aws:secretsmanager:${var.region}:${var.account}:secret:${var.jwt_config}",
                "arn:aws:secretsmanager:${var.region}:${var.account}:secret:${var.ENC_KEY}",
                "arn:aws:secretsmanager:${var.region}:${var.account}:secret:${var.GMS_KEYS}",
                "arn:aws:secretsmanager:${var.region}:${var.account}:secret:${var.STRIKEIRON_CREDENTIAL}",
                "arn:aws:secretsmanager:${var.region}:${var.account}:secret:${var.error_logger_secret}",
                "arn:aws:secretsmanager:${var.region}:${var.account}:secret:${var.oauthtoken}",
                "arn:aws:secretsmanager:${var.region}:${var.account}:secret:${var.leap_auth_provider_keys}",
                "arn:aws:secretsmanager:${var.region}:${var.account}:secret:${var.iden_encrypt_secret}",
                "arn:aws:secretsmanager:${var.region}:${var.account}:secret:${var.sa_get_rg_secret}"
            ]
        }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment_LambdaBasicExecutionRole" {
  role          = data.aws_iam_role.eks_role.name 
  policy_arn    = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
