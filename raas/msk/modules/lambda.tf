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
  description   = "secrets automatic rotation"
  role          = aws_iam_role.iam_role_rotation.arn
  handler       = "lambda_function.lambda_handler"
  timeout       = 60
  memory_size   = 128
  source_code_hash = filebase64sha256("${data.archive_file.zipit.output_path}")
  runtime = "python3.8"
  
  tags = {
    Name        = var.lambda_name
    Environment = var.environment
    map-migrated= var.map-migrated-server-id
  }

   depends_on = [
    aws_iam_role.iam_role_rotation
  ]
}

## Settting the permission 
resource "aws_lambda_permission" "lambda_permission" {
  statement_id   = "SecretsManagerAccess"
  action         = "lambda:InvokeFunction"
  function_name  = aws_lambda_function.lambda.arn
  principal      = "secretsmanager.amazonaws.com"

    depends_on = [
    aws_lambda_function.lambda
  ]
}

