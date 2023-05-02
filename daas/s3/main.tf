provider "aws" {
  region          = var.region
  assume_role {
    role_arn      = "arn:aws:iam::${var.account}:role/Jenkins-Role"
  }
}

module s3 {
  source                                  = "./modules"
  bucket_list                             = var.bucket_list
  region                                  = var.region
  account                                 = var.account
  environment                             = var.environment
  map-migrated-server-id                  = var.map-migrated-server-id
  sqs_account                             = var.sqs_account
  existing_bucket_name_incoming_external  = var.existing_bucket_name_incoming_external
  lambda_arn_hosted_preprocess            = var.lambda_arn_hosted_preprocess
  lambda_arn_file_decrypt                 = var.lambda_arn_file_decrypt
  lambda_arn_file_rename                  = var.lambda_arn_file_rename
  lambda_arn_file_s3_to_sftp              = var.lambda_arn_file_s3_to_sftp
  existing_sqs_queue_arn_snowpipe         = var.existing_sqs_queue_arn_snowpipe
  incoming_external_objects               = var.incoming_external_objects
  bucket_name_mwaa                        = var.bucket_name_mwaa
  mwaa_bucket_objects                     = var.mwaa_bucket_objects
  inbound_objects                         = var.inbound_objects
  daas_processing_objects                 = var.daas_processing_objects
  existing_bucket_name_inbound            = var.existing_bucket_name_inbound
  existing_bucket_name_outbound           = var.existing_bucket_name_outbound
  bucket_name_daas_processing             = var.bucket_name_daas_processing 
  lifecycle_45_days                       = var.lifecycle_45_days
  lifecycle_60_days                       = var.lifecycle_60_days
  lifecycle_30_days                       = var.lifecycle_30_days
  s3_logs_objects                         = var.s3_logs_objects
  bucket_name_logs                        = var.bucket_name_logs
  lifecycle_logs_day                      = var.lifecycle_logs_day
  lifecycle_logs_days                     = var.lifecycle_logs_days
  lambda_arn_igaming                      = var.lambda_arn_igaming
  existing_bucket_name_incoming_external_sox  = var.existing_bucket_name_incoming_external_sox
  incoming_external_sox_objects               = var.incoming_external_sox_objects
  lambda_arn_ethnicity                        = var.lambda_arn_ethnicity
}
