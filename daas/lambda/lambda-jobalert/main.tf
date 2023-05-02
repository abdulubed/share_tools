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
  description   = "Sends Emails."
  role          = data.aws_iam_role.lambda.arn
  handler       = "lambda_function.lambda_handler"
  timeout       = 15
  memory_size   = 128
  source_code_hash = filebase64sha256("${data.archive_file.zipit.output_path}")
  runtime = "python3.9"
  
  vpc_config   {
    subnet_ids          = var.subnet_ids
    security_group_ids  = var.security_group_ids
  }
  
  environment {
    variables = {
      ENV   = var.env
      ALERT_CFG_FILE   = var.alert_cfg_file
    }
  }
  tags = {
    Name        = var.lambda_name
    Environment = var.environment
    map-migrated= var.map-migrated-server-id
  }
}

resource "aws_lambda_function_event_invoke_config" "invoke" {
  function_name                = var.lambda_name
  maximum_event_age_in_seconds = 60
  maximum_retry_attempts       = 0
  depends_on = [
    aws_lambda_function.lambda
  ]
}
 
resource "aws_lambda_permission" "allow_trigger" {
  count      = "${length(var.source_arn)}"
  action         = "lambda:InvokeFunction"
  function_name  = var.lambda_name
  principal      = "logs.${var.region}.amazonaws.com"
  source_arn     = "${var.source_arn[count.index]}"
  source_account = var.account
    depends_on = [
    aws_lambda_function.lambda
  ]
}

resource "aws_cloudwatch_log_subscription_filter" "lambdafunction_logfilter" {
  count      = "${length(var.log_group_name)}"
  name = "${var.filter_names[count.index]}"
  log_group_name = "${var.log_group_name[count.index]}"
  filter_pattern  = var.filter_pattern
  destination_arn = aws_lambda_function.lambda.arn
   depends_on = [
    aws_lambda_function.lambda,
    aws_lambda_permission.allow_trigger
  ]
} 

