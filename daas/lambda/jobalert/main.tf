provider "aws" {
  region          = var.region
  assume_role {
    role_arn      = "arn:aws:iam::${var.account}:role/Jenkins-Role"
  }
}

## Existing role in AWS account 
data "aws_iam_role" "lambda" {
  name = var.existing_lambda_role
}

## Archiving the files for lambda function
data "archive_file" "zipit" {
  type        = "zip"
  output_path = "${var.deploy_lambda_file_path}"
  source_dir  = "./tf_lambda/"
}

## Lambda function will be created
resource "aws_lambda_function" "lambda" {
  filename      = data.archive_file.zipit.output_path
  function_name = var.lambda_name
  description   = "Sends Email"
  role          = data.aws_iam_role.lambda.arn
  handler       = "lambda_function.lambda_handler"

  vpc_config   {
    subnet_ids          = var.subnet_ids
    security_group_ids  = var.security_group_ids
  }

  source_code_hash  = filebase64sha256("${data.archive_file.zipit.output_path}")
  timeout           = 900
  runtime           = "python3.9"

  tags = {
    Name        = var.lambda_name
    Environment = var.environment
    map-migrated= var.map-migrated-server-id
  }
}

resource "aws_api_gateway_rest_api" "job_alert_api" {
  name        = "jobalert-api"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
  description = "API for Snowflake API to Send Alerts"
}

resource "aws_api_gateway_resource" "job_alert_resource" {
  rest_api_id = aws_api_gateway_rest_api.job_alert_api.id
  parent_id   = aws_api_gateway_rest_api.job_alert_api.root_resource_id
  path_part   = "jobalert"
}

resource "aws_api_gateway_method" "job_alert_method" {
  rest_api_id   = aws_api_gateway_rest_api.job_alert_api.id
  resource_id   = aws_api_gateway_resource.job_alert_resource.id
  http_method   = "POST"
  authorization = "AWS_IAM"
}

resource "aws_api_gateway_integration" "job_alert_integration" {
  rest_api_id             = aws_api_gateway_rest_api.job_alert_api.id
  resource_id             = aws_api_gateway_resource.job_alert_resource.id
  http_method             = aws_api_gateway_method.job_alert_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda.invoke_arn
}

# Lambda
resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "arn:aws:execute-api:${var.region}:${var.account}:${aws_api_gateway_rest_api.job_alert_api.id}/*/${aws_api_gateway_method.job_alert_method.http_method}${aws_api_gateway_resource.job_alert_resource.path}"
}

resource "aws_api_gateway_rest_api_policy" "job_policy" {
  rest_api_id = aws_api_gateway_rest_api.job_alert_api.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:sts::${var.account}:assumed-role/${var.existing_api_role}/snowflake"
      },
      "Action": "execute-api:Invoke",
      "Resource": "${aws_api_gateway_rest_api.job_alert_api.execution_arn}/*"
    }
  ]
}
EOF
}

resource "aws_api_gateway_deployment" "job_alert_deployment" {

  depends_on = [
    aws_api_gateway_method.job_alert_method,
    aws_api_gateway_integration.job_alert_integration,
    aws_api_gateway_rest_api_policy.job_policy
  ]

  rest_api_id = aws_api_gateway_rest_api.job_alert_api.id
  stage_name  = var.environment
  lifecycle {
    create_before_destroy = true
  }
}

