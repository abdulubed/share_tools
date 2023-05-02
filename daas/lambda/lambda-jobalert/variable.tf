variable "existing_lambda_role" {}
variable "lambda_name" {}
variable "deploy_lambda_file_path" {}
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

variable "map-migrated-server-id" {
  type = string
  default = "d-server-03vkic1y0uzm11"
}

variable "alert_cfg_file" {
  type = string
}

variable "env" {
  type = string
}

variable "subnet_ids" {
  type = list
}

variable "security_group_ids" {
  type = list
}

variable "filter_names" {
  type = list
}

/* variable "filter_name_appflow" {
  type = string
}

variable "filter_name_job_alert" {
  type = string
}

variable "filter_name_flie_rename" {
  type = string
}

variable "filter_name_time_works" {
  type = string
}
 */
variable "filter_pattern" {
  type = string
}

variable "log_group_name" {
  type = list
}

variable "source_arn" {
  type = list
}


