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

variable "secrets_timeworks_decryption_key" {}
variable "decryption_key_description" {}
variable "secretkey_timeworks_decryption_key" {}
variable "secretvalue_timeworks_decryption_key" {}

variable "secrets_timeworks_decryption_passphrase" {}
variable "decryption_passphrase_description" {}
variable "secretkey_timeworks_decryption_passphrase" {}
variable "secretvalue_timeworks_decryption_passphrase" {}
