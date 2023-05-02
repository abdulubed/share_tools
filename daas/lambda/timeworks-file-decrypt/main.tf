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
  runtime           = "python3.7"
  filename          = data.archive_file.zipit.output_path
  function_name     = var.lambda_name
  description       = "An Amazon S3 trigger that rename and move files to target directory"
  role              = data.aws_iam_role.lambda.arn
  handler           = "lambda_function.lambda_handler"
  timeout           = 15    #secs
  memory_size       = 512   #in MBs
  source_code_hash  = filebase64sha256("${data.archive_file.zipit.output_path}")
  layers            = [aws_lambda_layer_version.python_gnupg_layer.arn]

  environment {
    variables = {
      passphrase      = "arn:aws:secretsmanager:${var.region}:${var.account}:secret:${var.secret_name_passphrase_arn}",
      decryption_key  = "arn:aws:secretsmanager:${var.region}:${var.account}:secret:${var.secret_name_decryption_key_arn}",
      region          = var.region
    }
  }

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

## Creating lambda layer
resource "aws_lambda_layer_version" "python_gnupg_layer" {
  layer_name = "python_gnupg"
  filename   = "./layers/python_gnupg.zip"
  compatible_runtimes = ["python3.7", "python3.8", "python3.9", "python3.6"]
  compatible_architectures = ["x86_64"]
}