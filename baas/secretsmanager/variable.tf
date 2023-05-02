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

variable "secrets_lambda_mtd_cvps_database_server1" {}
variable "database_server1_description" {}

variable "secrets_lambda_mtd_cvps_database_server2" {}
variable "database_server2_description" {}

variable "secrets_lambda_mtd_cvps_snowflake" {}
variable "database_snowflake_description" {}

variable "server1_username" {
  type = string
}

variable "server1_engine" {
  type = string
}
variable "server1_host" {
  type = string
}
variable "server1_port" {
  type = string
}

variable "server1_dbname" {
  type = string
}

variable "server2_username" {
  type = string
}

variable "server2_engine" {
  type = string
}
variable "server2_host" {
  type = string
}
variable "server2_port" {
  type = string
}

variable "server2_dbname" {
  type = string
}

variable "snowflake_username" {
  type = string
}

variable "snowflake_engine" {
  type = string
}
variable "snowflake_host" {
  type = string
}
variable "snowflake_port" {
  type = string
}

variable "snowflake_dbname" {
  type = string
}

variable "snowflake_schema" {
  type = string
}
variable "snowflake_role" {
  type = string
}
variable "snowflake_warehouse" {
  type = string
}

variable "snowflake_account" {
  type = string
}