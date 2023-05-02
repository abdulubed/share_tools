variable "account" {
  type = string
}

variable "server1_secret" {
  type = string
}

variable "server2_secret" {
  type = string
}

variable "snowflake" {
  type = string
}

variable "environment" {
  type = string
}

variable "region" {
  type = string
}

variable "s3_folder" {
  type = string
}

variable "s3_region" {
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

variable "map-migrated-server-id" {
  type = string
  default = "d-server-03vkic1y0uzm11"
}

variable "validate_mtd_lambda_exec_role" {
  type = string
}

variable "validate_mtd_lambda_exec_policy" {
  type = string
}

variable "aws_user_snowflake" {
  type = string
}

variable "aws_iam_snowflake_user_id" {
  type = string
}

# Define policy ARNs as list
variable "iam_policy_arn" {
  description = "IAM Policy to be attached to role"
  type = list
}