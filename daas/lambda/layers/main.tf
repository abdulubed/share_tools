provider "aws" {
  region          = var.region
  assume_role {
    role_arn      = "arn:aws:iam::${var.account}:role/Jenkins-Role"
  }
}

## Creating lambda layer
resource "aws_lambda_layer_version" "pandas_layer" {
  layer_name = "pandas_layer"
  filename   = "./layers/pandas.zip"
  compatible_runtimes = ["python3.7", "python3.8", "python3.9",]
  compatible_architectures = ["x86_64"]
}

resource "aws_lambda_layer_version" "openpyxl_layer" {
  layer_name = "openpyxl_layer"
  filename   = "./layers/openpyxl.zip"
  compatible_runtimes = ["python3.7", "python3.8", "python3.9"]
  compatible_architectures = ["x86_64"]
}