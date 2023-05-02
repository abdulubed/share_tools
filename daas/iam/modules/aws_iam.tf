provider "aws" {
  region          = var.region
  assume_role {
    role_arn      = "arn:aws:iam::${var.account}:role/Jenkins-Role"
  }
}

resource "aws_iam_user" "ebank_user" {
    name = var.ebank_user
    path = "/svc/"
    tags = {
      Name        = var.ebank_user
      Environment = var.environment
      map-migrated= var.map-migrated-server-id
    }
}

resource "aws_iam_policy" "iam_policy_ebank_user_policy" {
  name   = var.ebank_policy
  
  path   = "/"
  policy = data.aws_iam_policy_document.iam_policy_ebank_user_policy_doc.json
  tags = {
    Name        = var.ebank_policy
    Environment = var.environment
    map-migrated= var.map-migrated-server-id
  }
}

data "aws_iam_policy_document" "iam_policy_ebank_user_policy_doc" {
    statement {
            effect      = "Allow"
            actions     = ["s3:ListBucket", "s3:GetBucketLocation"]
            resources   = ["arn:aws:s3:::${var.s3_bucket_incoming_external}"]
            condition {
              test      = "StringLike"
              variable  = "s3:prefix"
              values    = ["ebank/*"]
            }
    }

    statement {
            effect      = "Allow"
            actions     = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
            resources   = ["arn:aws:s3:::${var.s3_bucket_incoming_external}/ebank/*"]
    }
}

resource "aws_iam_user_policy_attachment" "ebank_user-policy-attach" {
  user        = aws_iam_user.ebank_user.name
  policy_arn  = aws_iam_policy.iam_policy_ebank_user_policy.arn
}

## International Properties User Setup ##
resource "aws_iam_user" "pos_external_user" {
    name = var.pos_external_user
    path = "/svc/"
    tags = {
      Name        = var.pos_external_user
      Environment = var.environment
      map-migrated= var.map-migrated-server-id
    }
}

resource "aws_iam_policy" "iam_policy_pos_external_policy" {
  name   = var.pos_external_policy
  
  path   = "/"
  policy = data.aws_iam_policy_document.iam_policy_pos_external_user_policy_doc.json
  tags = {
    Name        = var.pos_external_policy
    Environment = var.environment
    map-migrated= var.map-migrated-server-id
  }
}

data "aws_iam_policy_document" "iam_policy_pos_external_user_policy_doc" {
    statement {
            effect      = "Allow"
            actions     = ["s3:ListBucket", "s3:GetBucketLocation"]
            resources   = ["arn:aws:s3:::${var.s3_bucket_incoming_external}"]
            condition {
              test     = "StringLike"
              variable = "s3:prefix"
              values = ["pos-external/*"]
            }
    }

    statement {
            effect      = "Allow"
            actions     = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
            resources   = ["arn:aws:s3:::${var.s3_bucket_incoming_external}/pos-external/*"]
    }
}

resource "aws_iam_user_policy_attachment" "pos_external_user-policy-attach" {
  user        = aws_iam_user.pos_external_user.name
  policy_arn  = aws_iam_policy.iam_policy_pos_external_policy.arn
}

## External pos user setup ##

resource "aws_iam_user" "pos_user" {
    name = var.pos_user
    path = "/svc/"
    tags = {
      Name        = var.pos_user
      Environment = var.environment
      map-migrated= var.map-migrated-server-id
    }
}

resource "aws_iam_policy" "iam_policy_pos_policy" {
  name   = var.pos_policy
  
  path   = "/"
  policy = data.aws_iam_policy_document.iam_policy_pos_user_policy_doc.json
  tags = {
    Name        = var.pos_policy
    Environment = var.environment
    map-migrated= var.map-migrated-server-id
  }
}

data "aws_iam_policy_document" "iam_policy_pos_user_policy_doc" {
    statement {
            effect      = "Allow"
            actions     = ["s3:ListBucket", "s3:GetBucketLocation"]
            resources   = ["arn:aws:s3:::${var.s3_bucket_incoming_external}"]
            condition {
              test      = "StringLike"
              variable  = "s3:prefix"
              values    = ["pos/*", "pos-archive/*", "pos-processing/*", "pos-processing-trigger/*"]
            }
    }

    statement {
            effect      = "Allow"
            actions     = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
            resources   = ["arn:aws:s3:::${var.s3_bucket_incoming_external}/pos/*",
                           "arn:aws:s3:::${var.s3_bucket_incoming_external}/pos-archive/*",
                           "arn:aws:s3:::${var.s3_bucket_incoming_external}/pos-processing/*",
                           "arn:aws:s3:::${var.s3_bucket_incoming_external}/pos-processing-trigger/*"
                          ]
    }
}

resource "aws_iam_user_policy_attachment" "pos_user-policy-attach" {
  user        = aws_iam_user.pos_user.name
  policy_arn  = aws_iam_policy.iam_policy_pos_policy.arn
}

# freedom pay user setup #
resource "aws_iam_user" "Freedom_pay_user" {
    name = var.Freedom_pay_user
    path = "/svc/"
    tags = {
      Name        = var.Freedom_pay_user
      Environment = var.environment
      map-migrated= var.map-migrated-server-id
    }
}

resource "aws_iam_policy" "iam_policy_Freedom_pay_policy" {
  name   = var.Freedom_pay_policy
  
  path   = "/"
  policy = data.aws_iam_policy_document.iam_policy_Freedom_pay_user_policy_doc.json
  tags = {
    Name        = var.Freedom_pay_policy
    Environment = var.environment
    map-migrated= var.map-migrated-server-id
  }
}

data "aws_iam_policy_document" "iam_policy_Freedom_pay_user_policy_doc" {
    statement {
            effect      = "Allow"
            actions     = ["s3:ListBucket", "s3:GetObject", "s3:PutObject", "s3:DeleteObject", "s3:GetBucketLocation"]
            resources   = ["arn:aws:s3:::${var.s3_bucket_freedom_pay}",
                           "arn:aws:s3:::${var.s3_bucket_freedom_pay}/*"
                          ]
    }
}

resource "aws_iam_user_policy_attachment" "Freedom_pay_user-policy-attach" {
  user        = aws_iam_user.Freedom_pay_user.name
  policy_arn  = aws_iam_policy.iam_policy_Freedom_pay_policy.arn
}

## pdb user setup ##

resource "aws_iam_user" "pdb_user" {
    name = var.pdb_user
    path = "/svc/"
    tags = {
      Name        = var.pdb_user
      Environment = var.environment
      map-migrated= var.map-migrated-server-id
    }
}

resource "aws_iam_policy" "iam_policy_pdb_user_policy" {
  name   = var.pdb_policy
  
  path   = "/"
  policy = data.aws_iam_policy_document.iam_policy_pdb_user_policy_doc.json
  tags = {
    Name        = var.pdb_policy
    Environment = var.environment
    map-migrated= var.map-migrated-server-id
  }
}

data "aws_iam_policy_document" "iam_policy_pdb_user_policy_doc" {
  statement {
            effect      = "Allow"
            actions     = ["s3:ListBucket", "s3:GetObject", "s3:PutObject", "s3:DeleteObject", "s3:GetBucketLocation"]
            resources   = ["arn:aws:s3:::${var.s3_bucket_pdb}",
                           "arn:aws:s3:::${var.s3_bucket_pdb}/*"
                          ]
    }
}

resource "aws_iam_user_policy_attachment" "pdb_user-policy-attach" {
  user        = aws_iam_user.pdb_user.name
  policy_arn  = aws_iam_policy.iam_policy_pdb_user_policy.arn
}

## Timeworks User Setup ##
resource "aws_iam_user" "timeworks_user" {
    name = var.timeworks_user
    path = "/svc/"

    tags = {
      Name        = var.timeworks_user
      Environment = var.environment
      map-migrated= var.map-migrated-server-id
    }
}

resource "aws_iam_policy" "iam_policy_timeworks_user_policy" {
  name   = var.timeworks_user_policy
  
  path   = "/"
  policy = data.aws_iam_policy_document.iam_policy_timeworks_user_policy_doc.json
  tags = {
    Name        = var.timeworks_user_policy
    Environment = var.environment
    map-migrated= var.map-migrated-server-id
  }
}

data "aws_iam_policy_document" "iam_policy_timeworks_user_policy_doc" {
    statement {
            effect      = "Allow"
            actions     = ["s3:ListBucket", "s3:GetBucketLocation"]
            resources   = ["arn:aws:s3:::${var.s3_bucket_incoming_external}"]
            condition {
              test     = "StringLike"
              variable = "s3:prefix"
              values = ["timeworks/encrypted/*",
                        "timeworks/in/*"
                       ]
            }
    }

    statement {
            effect      = "Allow"
            actions     = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
            resources   = ["arn:aws:s3:::${var.s3_bucket_incoming_external}/timeworks/encrypted/*",
                           "arn:aws:s3:::${var.s3_bucket_incoming_external}/timeworks/in/*"
                          ]
    }
}

resource "aws_iam_user_policy_attachment" "timeworks_user-policy-attach" {
  user        = aws_iam_user.timeworks_user.name
  policy_arn  = aws_iam_policy.iam_policy_timeworks_user_policy.arn
}

## MWAA Role, Policy, and Policy Attachment ##
resource "aws_iam_role" "iam_role_mwaa" {
  name = var.role_name_mwaa

  tags = {
    Name          = var.role_name_mwaa
    Environment   = var.environment
    map-migrated  = var.map-migrated-server-id
  }

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = ["airflow.amazonaws.com", 
                     "airflow-env.amazonaws.com"
                ]
        }
      },
    ]
  })
}

resource "aws_iam_policy" "iam_policy_mwaa" {
  name   = var.policy_name_mwaa
  
  path   = "/"
  policy = data.aws_iam_policy_document.iam_policy_doc_mwaa.json
  tags = {
    Name        = var.policy_name_mwaa
    Environment = var.environment
    map-migrated= var.map-migrated-server-id
  }
}

data "aws_iam_policy_document" "iam_policy_doc_mwaa" {
    statement {
            effect       = "Allow"
            actions      = ["airflow:PublishMetrics"]
            resources    = ["arn:aws:airflow:${var.region}:${var.account}:environment/${var.airflow_arn_mwaa}"]
    }

    statement {
            effect      = "Deny"
            actions     = ["s3:ListAllMyBuckets"]
            resources   = ["arn:aws:s3:::${var.s3_bucket_mwaa_dag}", "arn:aws:s3:::${var.s3_bucket_mwaa_dag}/*"]
    }

    statement {
            effect      = "Allow"
            actions     = ["s3:GetObject*", "s3:GetBucket*", "s3:List*"]
            resources   = ["arn:aws:s3:::${var.s3_bucket_mwaa_dag}", "arn:aws:s3:::${var.s3_bucket_mwaa_dag}/*"]
    }

    statement {
            effect      = "Allow"
            actions     = ["s3:List**", "s3:GetBucket*", "s3:GetObject*", "s3:PutObject*", "s3:DeleteObject*"]
            resources   = var.s3_buckets_mwaa
    }

    statement {
            effect      = "Allow"
            actions     = ["logs:CreateLogStream",
                            "logs:CreateLogGroup",
                            "logs:PutLogEvents",
                            "logs:GetLogEvents",
                            "logs:GetLogRecord",
                            "logs:GetLogGroupFields",
                            "logs:GetQueryResults"]
            resources    = ["arn:aws:logs:${var.region}:${var.account}:log-group:airflow-${var.airflow_arn_mwaa}-*"]
    }

    statement {
            effect      = "Allow"
            actions     = ["logs:DescribeLogGroups"]
            resources   = ["*"]
    }

    statement {
            effect      = "Allow"
            actions     = ["cloudwatch:PutMetricData"]
            resources   = ["*"]
    }

    statement {
            effect      = "Allow"
            actions     = [ "sqs:ChangeMessageVisibility",
                            "sqs:DeleteMessage",
                            "sqs:GetQueueAttributes",
                            "sqs:GetQueueUrl",
                            "sqs:ReceiveMessage",
                            "sqs:SendMessage"
                        ]
            resources    = ["arn:aws:sqs:${var.region}:*:airflow-celery-*"]
    }

    statement {
            effect  = "Allow"
            actions = [ 
                        "kms:Decrypt",
                        "kms:DescribeKey",
                        "kms:GenerateDataKey*",
                        "kms:Encrypt"
                    ]
            not_resources    = ["arn:aws:kms:*:${var.account}:key/*"]
            condition {
                        test     = "StringLike"
                        variable = "kms:ViaService"

                        values = [
                            "sqs.${var.region}.amazonaws.com",
                            ]
                    }
    }
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment_mwaa" {
  role        = aws_iam_role.iam_role_mwaa.name
  policy_arn  = aws_iam_policy.iam_policy_mwaa.arn
}

#IAM Role for autoscaler:
data "aws_iam_policy_document" "oidc" {
  statement {
    effect  = "Allow"
    actions   = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
	    identifiers = ["arn:aws:iam::${var.account}:oidc-provider/${var.provider_url}"]
    }
    condition {
      test     = "StringEquals"
      variable = "${var.provider_url}:sub"
      values = [
        "system:serviceaccount:kube-system:cluster-autoscaler",
      ]
    }
  }
}

resource "aws_iam_role" "AmazonEKSClusterAutoscalerRole" {
  name = var.AmazonEKSClusterAutoscalerRole
  assume_role_policy = join("", data.aws_iam_policy_document.oidc.*.json)
  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name        = var.AmazonEKSClusterAutoscalerRole
    Environment = var.environment
    map-migrated= var.map-migrated-server-id
  }
}

resource "aws_iam_policy" "AmazonEKSClusterAutoscalerPolicy" {
  name = var.AmazonEKSClusterAutoscalerPolicy

  policy = jsonencode({
    Version = "2012-10-17"
    "Statement": [
        {
          "Action": [
              "autoscaling:DescribeAutoScalingGroups",
              "autoscaling:DescribeAutoScalingInstances",
              "autoscaling:DescribeLaunchConfigurations",
              "autoscaling:DescribeTags",
              "autoscaling:SetDesiredCapacity",
              "autoscaling:TerminateInstanceInAutoScalingGroup",
              "ec2:DescribeLaunchTemplateVersions"
          ],
          "Resource": "*",
          "Effect": "Allow"
        }
    ]
  })
  tags = {
    Name        = var.AmazonEKSClusterAutoscalerPolicy
    Environment = var.environment
    map-migrated= var.map-migrated-server-id
  }
}

/*data "aws_eks_cluster" "eks" {
  name = "${var.eks_name}"
}

data "tls_certificate" "eks" {
  url = data.aws_eks_cluster.eks.identity.0.oidc.0.issuer
}*/

resource "aws_iam_role_policy_attachment" "eks_iam_attach" {
  role        = aws_iam_role.AmazonEKSClusterAutoscalerRole.name
  policy_arn  = aws_iam_policy.AmazonEKSClusterAutoscalerPolicy.arn
}


/*resource "aws_iam_openid_connect_provider" "OpenID" {
  url = "https://${var.provider_url}"

  client_id_list = [
    "sts.amazonaws.com",
  ]

  thumbprint_list = [data.tls_certificate.eks.certificates.0.sha1_fingerprint]

  tags = {
    Environment = var.environment
    map-migrated= var.map-migrated-server-id
  }  
} 
*/

resource "aws_iam_role" "hosted_preprocess_lambda_exec_role" {
  name = var.hosted_preprocess_lambda_exec_role

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = ["lambda.amazonaws.com"]
        }
      },
    ]
  })

  tags = {
    Name        = var.hosted_preprocess_lambda_exec_role
    Environment = var.environment
    map-migrated= var.map-migrated-server-id
  }
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment_hosted_preprocess1" {
  role        = aws_iam_role.hosted_preprocess_lambda_exec_role.name
  policy_arn  = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment_hosted_preprocess2" {
  role        = aws_iam_role.hosted_preprocess_lambda_exec_role.name
  policy_arn  = aws_iam_policy.iam_policy_pos_policy.arn
}

## Timeworks Lambda Execution Role, Policy, and Policy Attachment ##
resource "aws_iam_role" "iam_role_file_decrypt" {
  name = var.file_decrypt_lambda_exec_role

  tags = {
    Name        = var.file_decrypt_lambda_exec_role
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

resource "aws_iam_role_policy" "iam_inline_policy_file_decrypt_lambda" {
    name = var.file_decrypt_lambda_exec_policy
    role = aws_iam_role.iam_role_file_decrypt.id
    policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "secretsmanager:ListSecretVersionIds",
          "secretsmanager:GetSecretValue",
          "secretsmanager:GetResourcePolicy",
          "secretsmanager:DescribeSecret"
        ]
        Effect   = "Allow"
        Resource = var.file_decrypt_secret_arns
      },
      {
        "Action": [
                "lambda:InvokeFunction",
                "lambda:InvokeAsync"
            ],
            "Effect": "Allow",
            "Resource": "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment_file_decrypt1" {
  role        = aws_iam_role.iam_role_file_decrypt.name
  policy_arn  = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment_file_decrypt2" {
  role        = aws_iam_role.iam_role_file_decrypt.name
  policy_arn  = "arn:aws:iam::aws:policy/AWSLambdaExecute"
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment_file_decrypt3" {
  role        = aws_iam_role.iam_role_file_decrypt.name
  policy_arn  = aws_iam_policy.iam_policy_timeworks_user_policy.arn
}

## File Rename Lambda Execution Role, Policy, and Policy Attachment ##
resource "aws_iam_role" "iam_role_file_rename" {
  name = var.file_rename_lambda_exec_role

  tags = {
    Name        = var.file_rename_lambda_exec_role
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

resource "aws_iam_policy" "iam_policy_file_rename_lambda" {
  name   = var.file_rename_lambda_exec_policy
  
  path   = "/"
  policy = data.aws_iam_policy_document.iam_policy_doc_file_rename_lambda.json
  tags = {
    Name        = var.file_rename_lambda_exec_policy
    Environment = var.environment
    map-migrated= var.map-migrated-server-id
  }
}

data "aws_iam_policy_document" "iam_policy_doc_file_rename_lambda" {
  statement {
            effect      = "Allow"
            actions     = ["s3:ListBucket", "s3:GetBucketLocation"]
            resources   = ["arn:aws:s3:::${var.s3_bucket_incoming_external}"]
            condition {
              test     = "StringLike"
              variable = "s3:prefix"
              values = ["timeworks/in/*",
                        "timeworks/out/*",
                        "pos-external/yardhouse/in/*",
                        "pos-external/yardhouse/out/*",
                        "pos-external/d365/in/*",
                        "pos-external/d365/out/*",
                        "pos-external/norfillmore/in/*",
                        "pos-external/norfillmore/out/*",
                        "pos-external/dubaibw/in/*",
                        "pos-external/dubaibw/out/*",
                        "pos-external/agilysys/in/*",
                        "pos-external/agilysys/out/*",
                        "pos-external/dba/in/*",
                        "pos-external/dba/out/*",
                        "pos-external/onprem/in/*",
                        "pos-external/onprem/out/*",
                        "pos-external/chayolinq/in/*",
                        "pos-external/chayolinq/out/*"
                       ]
            }
    }

    statement {
            effect      = "Allow"
            actions     = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
            resources   = ["arn:aws:s3:::${var.s3_bucket_incoming_external}/timeworks/in/*",
                           "arn:aws:s3:::${var.s3_bucket_incoming_external}/timeworks/out/*",
                           "arn:aws:s3:::${var.s3_bucket_incoming_external}/pos-external/yardhouse/in/*",
                           "arn:aws:s3:::${var.s3_bucket_incoming_external}/pos-external/yardhouse/out/*",
                           "arn:aws:s3:::${var.s3_bucket_incoming_external}/pos-external/d365/in/*",
                           "arn:aws:s3:::${var.s3_bucket_incoming_external}/pos-external/d365/out/*",
                           "arn:aws:s3:::${var.s3_bucket_incoming_external}/pos-external/norfillmore/in/*",
                           "arn:aws:s3:::${var.s3_bucket_incoming_external}/pos-external/norfillmore/out/*",
                           "arn:aws:s3:::${var.s3_bucket_incoming_external}/pos-external/dubaibw/in/*",
                           "arn:aws:s3:::${var.s3_bucket_incoming_external}/pos-external/dubaibw/out/*",
                           "arn:aws:s3:::${var.s3_bucket_incoming_external}/pos-external/agilysys/in/*",
                           "arn:aws:s3:::${var.s3_bucket_incoming_external}/pos-external/agilysys/out/*",
                           "arn:aws:s3:::${var.s3_bucket_incoming_external}/pos-external/dba/in/*",
                           "arn:aws:s3:::${var.s3_bucket_incoming_external}/pos-external/dba/out/*",
                           "arn:aws:s3:::${var.s3_bucket_incoming_external}/pos-external/onprem/in/*",
                           "arn:aws:s3:::${var.s3_bucket_incoming_external}/pos-external/onprem/out/*",
                           "arn:aws:s3:::${var.s3_bucket_incoming_external}/pos-external/chayolinq/in/*",
                           "arn:aws:s3:::${var.s3_bucket_incoming_external}/pos-external/chayolinq/out/*"
                          ]
    }
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment_file_rename1" {
  role        = aws_iam_role.iam_role_file_rename.name
  policy_arn  = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment_file_rename2" {
  role        = aws_iam_role.iam_role_file_rename.name
  policy_arn  = aws_iam_policy.iam_policy_file_rename_lambda.arn
}

## JobAlert Lambda Execution Role, Policy, and Policy Attachment ##
resource "aws_iam_role" "iam_role_jobalert" {
  name = var.jobalert_lambda_exec_role
  description = "Allows Lambda functions to call AWS services on your behalf."

  tags = {
    Name        = var.jobalert_lambda_exec_role
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

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment_jobalert" {
   depends_on = [
    aws_iam_role.iam_role_jobalert
  ]
  role       = aws_iam_role.iam_role_jobalert.name
  count      = "${length(var.job_alert_iam_policy_arn)}"
  policy_arn = "${var.job_alert_iam_policy_arn[count.index]}"
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

#role for sftp_file_transfer
resource "aws_iam_role" "sftp_file_transfer_lambda_exec_role" {
  name = var.sftp_file_transfer_lambda_exec_role

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = ["lambda.amazonaws.com"]
        }
      },
    ]
  })

  tags = {
    Name        = var.sftp_file_transfer_lambda_exec_role
    Environment = var.environment
    map-migrated= var.map-migrated-server-id
  }
}

resource "aws_iam_role_policy_attachment" "role_policy_attachment_sftp_file_transfer" {
   depends_on = [
    aws_iam_role.sftp_file_transfer_lambda_exec_role
  ]
  role        = aws_iam_role.sftp_file_transfer_lambda_exec_role.name
  count      = "${length(var.iam_policy_arn)}"
  policy_arn = "${var.iam_policy_arn[count.index]}"
}

## SOX user setup ##

resource "aws_iam_user" "sox_user" {
    name = var.sox_user
    path = "/svc/"
    tags = {
      Name        = var.sox_user
      Environment = var.environment
      map-migrated= var.map-migrated-server-id
    }
}

resource "aws_iam_policy" "iam_policy_sox_user_policy" {
  name   = var.sox_policy
  
  path   = "/"
  policy = data.aws_iam_policy_document.iam_policy_sox_user_policy_doc.json
  tags = {
    Name        = var.sox_policy
    Environment = var.environment
    map-migrated= var.map-migrated-server-id
  }
}

data "aws_iam_policy_document" "iam_policy_sox_user_policy_doc" {
  statement {
            effect      = "Allow"
            actions     = ["s3:*"]
            resources   = ["arn:aws:s3:::${var.s3_bucket_sox}",
                           "arn:aws:s3:::${var.s3_bucket_sox}/*"
                          ]
    }
}

resource "aws_iam_user_policy_attachment" "sox_user-policy-attach" {
  user        = aws_iam_user.sox_user.name
  policy_arn  = aws_iam_policy.iam_policy_sox_user_policy.arn
}

## igaming user setup ##

resource "aws_iam_user" "igaming_user" {
    name = var.igaming_user
    path = "/svc/"
    tags = {
      Name        = var.igaming_user
      Environment = var.environment
      map-migrated= var.map-migrated-server-id
    }
}

data "aws_iam_policy_document" "iam_policy_igaming_user_policy_doc" {
 statement {
            effect      = "Allow"
            actions     = ["s3:ListBucket", "s3:GetBucketLocation"]
            resources   = ["arn:aws:s3:::${var.s3_bucket_incoming_external}"]
            condition {
              test      = "StringLike"
              variable  = "s3:prefix"
              values    = ["iGaming/*"]
            }
    }

    statement {
            effect      = "Allow"
            actions     = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
            resources   = ["arn:aws:s3:::${var.s3_bucket_incoming_external}/iGaming/*"
                          ]
    }
}

resource "aws_iam_policy" "iam_policy_igaming_user_policy" {
  name   = var.igaming_policy
  
  path   = "/"
  policy = data.aws_iam_policy_document.iam_policy_igaming_user_policy_doc.json
  tags = {
    Name        = var.igaming_policy
    Environment = var.environment
    map-migrated= var.map-migrated-server-id
  }
}

resource "aws_iam_user_policy_attachment" "igaming_user-policy-attach" {
  user        = aws_iam_user.igaming_user.name
  policy_arn  = aws_iam_policy.iam_policy_igaming_user_policy.arn
}

### Igaming Lambda Execution Role, Policy, and Policy Attachment ###
resource "aws_iam_role" "iam_role_igaming" {
  name = var.igaming_lambda_exec_role

  tags = {
    Name        = var.igaming_lambda_exec_role
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

resource "aws_iam_policy" "iam_policy_igaming_lambda" {
  name   = var.igaming_lambda_exec_policy
  
  path   = "/"
  policy = data.aws_iam_policy_document.iam_policy_doc_igaming_lambda.json
  tags = {
    Name        = var.igaming_lambda_exec_policy
    Environment = var.environment
    map-migrated= var.map-migrated-server-id
  }
}

data "aws_iam_policy_document" "iam_policy_doc_igaming_lambda" {
  statement {
            effect      = "Allow"
            actions     = ["s3:ListBucket", "s3:GetBucketLocation"]
            resources   = ["arn:aws:s3:::${var.s3_bucket_incoming_external}"]
            condition {
              test     = "StringLike"
              variable = "s3:prefix"
              values = ["iGaming/in/*",
                        "iGaming/processing/*",
                        "iGaming/out/*"
                       ]
            }
    }

    statement {
            effect      = "Allow"
            actions     = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
            resources   = [ "arn:aws:s3:::${var.s3_bucket_incoming_external}/iGaming/out/*",
                            "arn:aws:s3:::${var.s3_bucket_incoming_external}/iGaming/processing/*",
                            "arn:aws:s3:::${var.s3_bucket_incoming_external}/iGaming/in/*"                        
                          ]
    }
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment_igaming1" {
  role        = aws_iam_role.iam_role_igaming.name
  policy_arn  = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment_igaming2" {
  role        = aws_iam_role.iam_role_igaming.name
  policy_arn  = aws_iam_policy.iam_policy_igaming_lambda.arn
}

## shelf ethnicity user setup ##

resource "aws_iam_user" "ethnicity_user" {
    name = var.ethnicity_user
    path = "/svc/"
    tags = {
      Name        = var.ethnicity_user
      Environment = var.environment
      map-migrated= var.map-migrated-server-id
    }
}

data "aws_iam_policy_document" "iam_policy_ethnicity_user_policy_doc" {
 statement {
            effect      = "Allow"
            actions     = ["s3:ListBucket", "s3:GetBucketLocation"]
            resources   = ["arn:aws:s3:::${var.s3_bucket_outbound}"]
            condition {
              test      = "StringLike"
              variable  = "s3:prefix"
              values    = ["SHELF_ ETHNICITY_EXTRACT/*"]
            }
    }

    statement {
            effect      = "Allow"
            actions     = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
            resources   = ["arn:aws:s3:::${var.s3_bucket_outbound}/SHELF_ ETHNICITY_EXTRACT/*"
                          ]
    }
}

resource "aws_iam_policy" "iam_policy_ethnicity_user_policy" {
  name   = var.ethnicity_policy
  
  path   = "/"
  policy = data.aws_iam_policy_document.iam_policy_ethnicity_user_policy_doc.json
  tags = {
    Name        = var.ethnicity_policy
    Environment = var.environment
    map-migrated= var.map-migrated-server-id
  }
}

resource "aws_iam_user_policy_attachment" "ethnicity-user-policy-attach" {
  user        = aws_iam_user.ethnicity_user.name
  policy_arn  = aws_iam_policy.iam_policy_ethnicity_user_policy.arn
}

## shelf user setup ##

resource "aws_iam_user" "shelf_user" {
    name = var.shelf_user
    path = "/svc/"
    tags = {
      Name        = var.shelf_user
      Environment = var.environment
      map-migrated= var.map-migrated-server-id
    }
}

data "aws_iam_policy_document" "iam_policy_shelf_user_policy_doc" {
 statement {
            effect      = "Allow"
            actions     = ["s3:ListBucket", "s3:GetBucketLocation"]
            resources   = ["arn:aws:s3:::${var.s3_bucket_incoming_external}"]
            condition {
              test      = "StringLike"
              variable  = "s3:prefix"
              values    = ["shelf/*"]
            }
    }

    statement {
            effect      = "Allow"
            actions     = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
            resources   = ["arn:aws:s3:::${var.s3_bucket_incoming_external}/shelf/*"
                          ]
    }
}

resource "aws_iam_policy" "iam_policy_shelf_user_policy" {
  name   = var.shelf_policy
  
  path   = "/"
  policy = data.aws_iam_policy_document.iam_policy_shelf_user_policy_doc.json
  tags = {
    Name        = var.shelf_policy
    Environment = var.environment
    map-migrated= var.map-migrated-server-id
  }
}

resource "aws_iam_user_policy_attachment" "shelf_user_policy_attach" {
  user        = aws_iam_user.shelf_user.name
  policy_arn  = aws_iam_policy.iam_policy_shelf_user_policy.arn
}

resource "aws_iam_role" "iam_role_ethnicity" {
  name = var.ethnicity_lambda_role
  assume_role_policy = jsonencode({
   "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
})
  tags = {
    Name                   = var.ethnicity_lambda_role
    Environment            = var.environment
    map-migrated           = var.map-migrated-server-id
  }
}

resource "aws_iam_policy" "ethnicity_policy" {
  name = var.ethnicity_lambda_policy
  description = "lambda policy for shelf etnicity"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:GetBucketLocation"
            ],
            "Condition": {
                "StringLike": {
                    "s3:prefix": [
                        "shelf/ethnicity/in/*",
                        "shelf/ethnicity/processing/*",
                        "shelf/ethnicity/out/*"
                    ]
                }
            },
            "Resource": [ 
			    "arn:aws:s3:::${var.s3_bucket_incoming_external}"
				]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:DeleteObject"
            ],
            "Resource": [
                "arn:aws:s3:::${var.s3_bucket_incoming_external}/shelf/ethnicity/out/*",
                "arn:aws:s3:::${var.s3_bucket_incoming_external}/shelf/ethnicity/in/*",
                "arn:aws:s3:::${var.s3_bucket_incoming_external}/shelf/ethnicity/processing/*"
            ]
        }
    ]
}
EOF
depends_on = [
    aws_iam_role.iam_role_ethnicity
  ]
}

resource "aws_iam_role_policy_attachment" "ethnicity_policy_attachment" {
  role        = aws_iam_role.iam_role_ethnicity.name
  policy_arn  = aws_iam_policy.ethnicity_policy.arn
}

# attach policy to the ethinicity role
resource "aws_iam_role_policy_attachment" "role-policy-attachment" {
  role        = aws_iam_role.iam_role_ethnicity.name
  count      = "${length(var.ethnicity_iam_policy_arn)}"
  policy_arn = "${var.ethnicity_iam_policy_arn[count.index]}"
}