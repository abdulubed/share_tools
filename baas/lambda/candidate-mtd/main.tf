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

## Archiving the files for candidate lambda function
data "archive_file" "candidate_zipit" {
  type        = "zip"
  output_path = "${var.deploy_candidate_lambda_file_path}"
  source_dir  = "./tf_lambda"
}

data "aws_lambda_layer_version" "existing_layer_name" {
  layer_name = var.existing_layer_name
}

## candidate Lambda function will be created
resource "aws_lambda_function" "candidate" {
  filename      = data.archive_file.candidate_zipit.output_path
  function_name = var.lambda_name
  description   = "BaaS - Month to Date deep candidate"
  role          = data.aws_iam_role.lambda.arn
  handler       = "index.lambdaHandler"
  layers        = [data.aws_lambda_layer_version.existing_layer_name.arn]

  publish = true

  vpc_config   {
    subnet_ids          = var.subnet_ids
    security_group_ids  = var.security_group_ids
  }

  source_code_hash  = filebase64sha256("${data.archive_file.candidate_zipit.output_path}")
  timeout           = 900
  runtime           = "nodejs14.x"

  environment {
    variables = {
      REGION        = var.region
    }
  }
  
  tags = {
    Name        = var.lambda_name
    Environment = var.environment
    map-migrated= var.map-migrated-server-id
  }
}
