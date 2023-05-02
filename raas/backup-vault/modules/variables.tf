# EC2 Instance Variables
variable "account" {
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

variable "region_code" {
  type = string
  default = "usw2"
}

variable "map-migrated-server-id" {
  type = string
  default = "d-server-03vkic1y0uzm11"
}

variable "aws_backup_vault" {
  type = string
}

variable "kms_key" {
  type = string
}

variable "aws_iam_role" {
  type = string
}

variable "iam_policy_arn" {
  type = list
}




 
