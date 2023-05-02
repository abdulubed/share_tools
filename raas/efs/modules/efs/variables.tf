variable "account" {
  type = string
}

variable "region" {
  type = string
}

variable "map-migrated" {
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

variable "encrypted" {
  type = string
}

variable "performance_mode" {
  type = string
}

variable "throughput_mode" {
  type = string
}

variable "efs_ingress_rules" {
  type = list
}

variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "into_IA" {
  type = string
}

variable "out_of_IA" {
  type = string
}

variable "associated_security_group_id" {
  type = string
}

variable "creation_token" {
  type = string
}