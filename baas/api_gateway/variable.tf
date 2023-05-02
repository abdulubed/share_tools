
variable "existing_lambda_role" {}
variable "existing_candidate_lambda" {}
variable "existing_validate_lambda" {}

variable "account" {}

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

variable "api_gateway_name" {
  type = string
}

variable "map-migrated-server-id" {
  type = string
  default = "d-server-03vkic1y0uzm11"
}

