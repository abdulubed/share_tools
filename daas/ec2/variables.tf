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

variable "subnet_id" {
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
 
variable "key_pair" {
    type = string
}

variable "aws_ami" {
  type = string  
}
 
variable "instance_type" {
    type = string 
}

variable "application" {
  type = string
}
   
variable "root_device_type" {
  description = "Type of the root block device"
  type        = string
}
 
variable "root_device_size" {
  description = "Size of the root block device"
  type        = string
}

variable "map-migrated-server-id" {
  type = string
  default = "d-server-03vkic1y0uzm11"
}

variable "region_code" {
  type = string
  default = "usw2"
}

variable "sg_ingress_rules_cidr" {
  type = list
}

variable "sg_ingress_rules_sg_ids_self" {
  type = list
}

variable "sg_ingress_rules_sg_ids_others" {
  type = list
}

variable "vpc_id" {
  type = string
}

variable "created-by" {
  type = string
  default = "Aws support team"
}

variable "contact-person" {
  type = string
  default = "Name: Amarthuluru, Ramesh (Mobile: +1 (508) 333-3274)"
}

variable "existing_backup_vault" {
  type = string
}

variable "backup_plan" {
  type = string
}

variable "existing_iam_role" {
  type = string
}

variable "backup_resource" {
  type = string
}

variable "daily_backup_rule" {
  type = string
}

variable "weekly_backup_rule" {
  type = string
}

variable "monthly_backup_rule" {
  type = string
}

variable "daily_backup_schedule" {
  type = string
}

variable "weekly_backup_schedule" {
  type = string
}

variable "monthly_backup_schedule" {
  type = string
}

variable "delete_after_7_days" {
  type = string
}

variable "delete_after_8_weeks" {
  type = string
}

variable "delete_after_1_year" {
  type = string
}

variable "availability_zone" {
  type = string
}

variable "additional_device_size" {
  type = list
}

variable "additional_device_name" {
  type = list
}

variable "additional_device_tag" {
  type = list
}

variable "private_ip" {
  type = string
} 

variable "iam_role_name" {
  type = string
}

variable "iam_profile_name" {
  type = string
}

variable "iam_policy_arn" {
  type = list
}

variable "secondary_private_ips" {
  type = list
}

variable "hostname" {
  default = ""
  type = string
}
