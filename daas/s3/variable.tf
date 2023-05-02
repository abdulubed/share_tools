
variable "bucket_list" {
  type = list
}

variable "environment" {
  type = string
}

variable "account" {
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

variable "existing_bucket_name_incoming_external" {
  type = string
}
 
variable "lambda_arn_hosted_preprocess" {
  type = string
}

variable "lambda_arn_file_decrypt" {
  type = string
}

variable "lambda_arn_file_rename" {
  type = string
}

variable "existing_sqs_queue_arn_snowpipe" {
  type = string
}

variable "sqs_account" {
  type = string
}

variable "incoming_external_objects" {
  type        = list
  description = "The list of S3 folders to create"
}

variable "existing_bucket_name_inbound" {
  type = string
}

variable "inbound_objects" {
  type        = list
  description = "The list of S3 folders to create"
}

variable "bucket_name_mwaa" {
  type = string
}

variable "mwaa_bucket_objects" {
  type        = list
  description = "The list of S3 folders to create for mwaa bucket"
}

variable "bucket_name_daas_processing" {
  type = string
}

variable "lifecycle_45_days" {
  type        = list
}

variable "lifecycle_60_days" {
  type        = list
}

variable "lifecycle_30_days" {
  type        = list
}

variable "lambda_arn_file_s3_to_sftp" {
  type = string
}

variable "existing_bucket_name_outbound" {
  type = string
}

variable "daas_processing_objects" {
  type = list
}

variable "s3_logs_objects" {
  type = list
}

variable "bucket_name_logs" {
  type = string
}

variable "lifecycle_logs_day" {
  type        = list
}

variable "lifecycle_logs_days" {
  type = string
}

variable "lambda_arn_igaming" {
  type = string
}

variable "existing_bucket_name_incoming_external_sox" {
  type = string
}

variable "incoming_external_sox_objects" {
  type = list
}

variable "lambda_arn_ethnicity" {
  type = string
}