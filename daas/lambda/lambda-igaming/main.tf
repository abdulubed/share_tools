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

data "aws_lambda_layer_version" "existing_layer_name" {
  count       = "${length(var.existing_layer_name)}"
  layer_name = "${element(var.existing_layer_name, count.index)}"
}

## Lambda function will be created
resource "aws_lambda_function" "lambda" {
  filename      = data.archive_file.zipit.output_path
  function_name = var.lambda_name
  description   = "An Amazon S3 trigger which splits the parent xml file into child files."
  role          = data.aws_iam_role.lambda.arn
  handler       = "lambda_function.lambda_handler"
  timeout       = 120
  memory_size   = 1512
  source_code_hash = filebase64sha256("${data.archive_file.zipit.output_path}")
  runtime = "python3.7"
  layers        = "${data.aws_lambda_layer_version.existing_layer_name.*.arn}"

  
  tags = {
    Name        = var.lambda_name
    Environment = var.environment
    map-migrated= var.map-migrated-server-id
  }
}

## Get exising bucket was created
data "aws_s3_bucket" "bucket" {
  bucket = var.existing_bucket_name
}

## Settting the permission 
resource "aws_lambda_permission" "allow_bucket" {
  statement_id   = "AllowExecutionFromS3Bucket"
  action         = "lambda:InvokeFunction"
  function_name  = aws_lambda_function.lambda.arn
  principal      = "s3.amazonaws.com"
  source_arn     = data.aws_s3_bucket.bucket.arn
  source_account = var.account
}
