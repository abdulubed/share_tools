provider "aws" {
  region          = var.region
  assume_role {
    role_arn      = "arn:aws:iam::${var.account}:role/Jenkins-Role"
  }
}

module "mwaa" {
  source                = "./modules"
  account               = var.account
  environment           = var.environment
  region                = var.region
  s3_folder             = var.s3_folder
  s3_region             = var.s3_region
  s3_folder_type        = var.s3_folder_type
  s3_bucket             = var.s3_bucket
  s3_tfstate_file       = var.s3_tfstate_file
  business_name         = var.business_name
  capability            = var.capability
  application_code      = var.application_code
  map-migrated-server-id= var.map-migrated-server-id
  mwaa_environment_name = var.mwaa_environment_name
  execution_role        = var.execution_role
  source_s3_bucket      = var.source_s3_bucket
  dag_s3_path           = var.dag_s3_path
  plugins_s3_path       = var.plugins_s3_path
  requirements_s3_path  = var.requirements_s3_path
  webserver_access_mode = var.webserver_access_mode
  environment_class     = var.environment_class
  max_workers           = var.max_workers
  min_workers           = var.min_workers
  vpc_id                = var.vpc_id
  subnet_ids            = var.subnet_ids
  security_group_ids    = var.security_group_ids
  schedulers            = var.schedulers
}