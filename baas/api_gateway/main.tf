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

data "aws_lambda_function" "existing_candidate_lambda" {
  function_name = var.existing_candidate_lambda
}

data "aws_lambda_function" "existing_validate_lambda" {
  function_name = var.existing_validate_lambda
}

resource "aws_api_gateway_rest_api" "api_gateway" {
  name        = var.api_gateway_name
  endpoint_configuration {
    types = ["REGIONAL"]
  }
  description = "Created by AWS Lambda"
}

resource "aws_api_gateway_resource" "api_gateway_resource" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_rest_api.api_gateway.root_resource_id
  path_part   = "deepvalidatemtd"
  depends_on = [
    aws_api_gateway_rest_api.api_gateway
  ]
}


resource "aws_api_gateway_method" "api_gateway_method" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.api_gateway_resource.id
  http_method   = "POST"
  authorization = "AWS_IAM"
  request_parameters = {
    "method.request.header.Content-Type" = true
  }
  request_models = {
    "application/json" = "Empty"
  }
  depends_on = [
    aws_api_gateway_rest_api.api_gateway,
    aws_api_gateway_resource.api_gateway_resource
  ]
}

resource "aws_api_gateway_integration" "api_gateway_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.api_gateway_resource.id
  http_method             = aws_api_gateway_method.api_gateway_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = data.aws_lambda_function.existing_validate_lambda.invoke_arn
  credentials             = data.aws_iam_role.lambda.arn

  depends_on = [
    aws_api_gateway_rest_api.api_gateway,
    aws_api_gateway_resource.api_gateway_resource,
    aws_api_gateway_method.api_gateway_method
  ]
}

resource "aws_api_gateway_method_response" "response" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.api_gateway_resource.id
  http_method = aws_api_gateway_method.api_gateway_method.http_method
  status_code = "200"
   response_models = {
      "application/json" = "Empty"
  }
   depends_on = [
    aws_api_gateway_rest_api.api_gateway,
    aws_api_gateway_resource.api_gateway_resource,
    aws_api_gateway_method.api_gateway_method,
  ]
}

resource "aws_api_gateway_integration_response" "integration_response" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.api_gateway_resource.id
  http_method = aws_api_gateway_method.api_gateway_method.http_method
  status_code = aws_api_gateway_method_response.response.status_code
  depends_on = [
    aws_api_gateway_rest_api.api_gateway,
    aws_api_gateway_resource.api_gateway_resource,
    aws_api_gateway_method.api_gateway_method,
    aws_api_gateway_integration.api_gateway_integration
  ]
}

#####
resource "aws_api_gateway_resource" "api_gateway_resource1" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_rest_api.api_gateway.root_resource_id
  path_part   = "validatemtd"
  depends_on = [
    aws_api_gateway_rest_api.api_gateway
  ]
}

resource "aws_api_gateway_method" "api_gateway_method1" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.api_gateway_resource1.id
  http_method   = "POST"
  authorization = "AWS_IAM"
  request_parameters = {
    "method.request.header.Content-Type" = true
  }
  request_models = {
    "application/json" = "Empty"
  }
  depends_on = [
    aws_api_gateway_rest_api.api_gateway,
    aws_api_gateway_resource.api_gateway_resource1
  ]
}

resource "aws_api_gateway_integration" "api_gateway_integration1" {
  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.api_gateway_resource1.id
  http_method             = aws_api_gateway_method.api_gateway_method1.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = data.aws_lambda_function.existing_candidate_lambda.invoke_arn
  credentials             = data.aws_iam_role.lambda.arn

   depends_on = [
    aws_api_gateway_rest_api.api_gateway,
    aws_api_gateway_resource.api_gateway_resource1,
    aws_api_gateway_method.api_gateway_method1
  ]
}

resource "aws_api_gateway_method_response" "response1" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.api_gateway_resource1.id
  http_method = aws_api_gateway_method.api_gateway_method1.http_method
  status_code = "200"
  response_models = {
      "application/json" = "Empty"
  }
  depends_on = [
    aws_api_gateway_rest_api.api_gateway,
    aws_api_gateway_resource.api_gateway_resource1,
    aws_api_gateway_method.api_gateway_method1
  ]
}

resource "aws_api_gateway_integration_response" "integration_response1" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.api_gateway_resource1.id
  http_method = aws_api_gateway_method.api_gateway_method1.http_method
  status_code = aws_api_gateway_method_response.response1.status_code
  response_templates = {
       "application/json" = "Empty"
   } 
   depends_on = [
    aws_api_gateway_rest_api.api_gateway,
    aws_api_gateway_resource.api_gateway_resource1,
    aws_api_gateway_method.api_gateway_method1,
    aws_api_gateway_integration.api_gateway_integration1
  ]
}

resource "aws_lambda_permission" "candidate_permission" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.aws_lambda_function.existing_candidate_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.region}:${var.account}:${aws_api_gateway_rest_api.api_gateway.id}/*/${aws_api_gateway_method.api_gateway_method1.http_method}${aws_api_gateway_resource.api_gateway_resource1.path}"
}

resource "aws_lambda_permission" "validate_permission" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.aws_lambda_function.existing_validate_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.region}:${var.account}:${aws_api_gateway_rest_api.api_gateway.id}/*/${aws_api_gateway_method.api_gateway_method.http_method}${aws_api_gateway_resource.api_gateway_resource.path}"
}

resource "aws_lambda_permission" "validate_permission1" {
  statement_id  = "my-custom-lambda-mtd-invoke"
  action        = "lambda:InvokeFunction"
  function_name = data.aws_lambda_function.existing_validate_lambda.function_name
  principal     = "lambda.amazonaws.com"

  source_arn = "arn:aws:execute-api:${var.region}:${var.account}:fucntion:${var.existing_validate_lambda}"
}

resource "aws_api_gateway_rest_api_policy" "lambda_mtd_policy" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:sts::${var.account}:assumed-role/${var.existing_lambda_role}/snowflake"
      },
      "Action": "execute-api:Invoke",
      "Resource": ["${aws_api_gateway_rest_api.api_gateway.execution_arn}/*/POST/snowflake",
      "${aws_api_gateway_rest_api.api_gateway.execution_arn}/*/POST/snowflake/validate",
      "${aws_api_gateway_rest_api.api_gateway.execution_arn}/*/POST/validatemtd",
      "${aws_api_gateway_rest_api.api_gateway.execution_arn}/*/POST/deepvalidatemtd"
      ]
    }
  ]
}
EOF
}

resource "aws_api_gateway_deployment" "candidate_mtd_deployment" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  stage_name  = var.environment
  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_api_gateway_rest_api.api_gateway,
    aws_api_gateway_method.api_gateway_method,
    aws_api_gateway_method.api_gateway_method1,
    aws_api_gateway_integration.api_gateway_integration,
    aws_api_gateway_integration.api_gateway_integration1,
    aws_api_gateway_method_response.response,
    aws_api_gateway_method_response.response1,
    aws_api_gateway_integration_response.integration_response,
    aws_api_gateway_integration_response.integration_response1
  ]
}
