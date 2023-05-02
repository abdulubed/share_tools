provider "aws" {
  region          = var.region
  assume_role {
    role_arn      = "arn:aws:iam::${var.account}:role/Jenkins-Role"
  }
}

## Archiving the files for validate lambda function
data "archive_file" "validate_zipit" {
  type        = "zip"
  output_path = "${var.deploy_validate_lambda_file_path}"
  source_dir  =  "./tf_lambda"
}

## Existing role in AWS account 
data "aws_iam_role" "lambda" {
  name = var.existing_lambda_role
}

data "aws_lambda_layer_version" "existing_layer_name" {
  layer_name = var.existing_layer_name
}

## validate Lambda function will be created
resource "aws_lambda_function" "validate" {
  filename      = data.archive_file.validate_zipit.output_path
  function_name = var.lambda_name
  description   = "BAAS - Month to Date deep Validate"
  role          = data.aws_iam_role.lambda.arn
  handler       = "index.lambdaHandler"
  layers        = [data.aws_lambda_layer_version.existing_layer_name.arn]
  publish = true
  
  vpc_config   {
    subnet_ids          = var.subnet_ids
    security_group_ids  = var.security_group_ids
  }

  source_code_hash  = filebase64sha256("${data.archive_file.validate_zipit.output_path}")
  timeout           = 900
  runtime           = "nodejs14.x"

  environment {
    variables = {
      SNOWFLAKE_DATABASE	            = var.snowflake_database
      SNOWFLAKE_KEY_STORE_ARN_SECRET  = var.snowflake_key_store_arn_secret
      REGION                          = var.region
    }
  }
  
  tags = {
    Name        = var.lambda_name
    Environment = var.environment
    map-migrated= var.map-migrated-server-id
  }
}

