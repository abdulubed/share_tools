provider "aws" {
  region          = var.region
  assume_role {
    role_arn      = "arn:aws:iam::${var.account}:role/Jenkins-Role"
  }
}

## Creating lambda layer
resource "aws_lambda_layer_version" "nodejslayer" {
  layer_name = "nodejslayer"
  filename   = "./layers/nodejslayer.zip"
  compatible_runtimes = ["nodejs14.x"]
  compatible_architectures = ["x86_64"]
}