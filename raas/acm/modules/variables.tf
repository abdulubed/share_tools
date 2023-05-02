variable "account" {
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

variable "environment" {
  type = string
}

variable "domain_name" {
  type = list
}

variable "validation_method" {
  type = string
}

variable "acm_certificate_name" {
  type = string
}

variable "map-migrated-server-id" {
  type = string
  default = "d-server-03vkic1y0uzm11"
}