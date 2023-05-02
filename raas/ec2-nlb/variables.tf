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

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
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

variable "deletion_protection_enabled" {
  type        = bool
  default     = true
}

variable "internal" {
  type = string  
}

variable "lb_name" {
  type = string  
}

variable "tg_name" {
  type = string  
}

variable "lbport" {
  type = string  
}

variable "instance_list" {
  type = list  
}

variable "target_type" {
  type = string  
}

variable "tgport" {
  type = string  
}