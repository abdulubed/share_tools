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

variable "business_name" {
  type = string
}

variable "capability" {
  type = string
}

variable "application_code" {
  type = string
}

variable "mwaa_environment_name" {
  type = string
}

variable "map-migrated-server-id" {
  type = string
  default = "d-server-03vkic1y0uzm11"
}

variable "execution_role" {
  type = string
}

variable "source_s3_bucket" {
  type = string
}

variable "dag_s3_path" {
  type = string
}

variable "plugins_s3_path" {
  type = string
}

variable "requirements_s3_path" {
  type = string
}

variable "webserver_access_mode" {
  type = string
}

variable "environment_class" {
  type = string
}

variable "max_workers" {
  type = string
}

variable "min_workers" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list
}

variable "security_group_ids" {
  type = list
}

 variable "schedulers" {
  type = string
}