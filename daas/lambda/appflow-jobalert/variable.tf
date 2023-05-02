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

variable "event_name_RunReport" {
  type = string
}

variable "event_name_Deactivated" {
  type = string
}
