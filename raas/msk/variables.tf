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

variable "map-migrated-server-id" {
  type = string
  default = "d-server-03vkic1y0uzm11"
}

variable "region_code" {
  type = string
  default = "usw2"
}

variable "cluster_name" {
  type = string
}

variable "kafka_version" {
  type = string
}

variable "number_of_broker_nodes" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "client_subnets" {
  type = list
}

## Cloud watch 
variable "retention_in_days" {
  type = string
}


variable "volume_size" {
  type = string
}

variable "application" {
  type = string
}

variable "sg_ingress_rules_cidr" {
  type = list
}

variable "vpc_id" {
  type = string
}

variable "policy_name_msk" {
  type = string
}

variable "policy_name_kms_secrets" {
  type = string
}

variable "enhanced_monitoring" {
  type = string
}

variable "msk_configuration_name" {
  type = string
}

variable "secret_msk" {
  type = string
}

variable "secret_rotation_lambda_exec_role" {
  type = string
}

variable "lambda_name" {
  type = string
}

variable "deploy_lambda_file_path" {
  type = string
}

variable "secrets_msk_name" {
  type = string
}

variable "msk_secret_description" {
  type = string
}

variable "msk_username" {
  type = string
}

variable "assume_exec_role" {
  type = string
}

variable "daas_account_number" {
  type = string
}


