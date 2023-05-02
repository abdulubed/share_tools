variable "existing_lambda_role" {}
variable "existing_api_role" {}
variable "lambda_name" {}
variable "deploy_lambda_file_path" {}
variable "account" {}
variable "vpc_id" {}

variable "security_group_ids" {
  type = list
}

variable "subnet_ids" {
  type = list
}

variable "environment" {
  type = string
}

variable "s3_folder" {
  type = string
}

variable "s3_folder_type" {
  type = string
}

variable "s3_tfstate_file" {
  type = string
}

variable "s3_bucket" {
  type = string
}

variable "s3_region" {
  type = string
}

variable "region" {
  type = string
}

variable "map-migrated-server-id" {
  type = string
  default = "d-server-03vkic1y0uzm11"
}
