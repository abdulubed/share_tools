provider "aws" {
  region          = var.region
  assume_role {
    role_arn      = "arn:aws:iam::${var.account}:role/Jenkins-Role"
  }
}

module "msk" {
  source                            = "./modules"
  region                            = var.region
  account                           = var.account
  client_subnets                    = var.client_subnets
  cluster_name                      = var.cluster_name
  application                       = var.application
  instance_type                     = var.instance_type
  kafka_version                     = var.kafka_version
  volume_size                       = var.volume_size
  number_of_broker_nodes            = var.number_of_broker_nodes
  s3_folder                         = var.s3_folder
  s3_region                         = var.s3_region
  s3_folder_type                    = var.s3_folder_type
  s3_bucket                         = var.s3_bucket
  s3_tfstate_file                   = var.s3_tfstate_file
  environment                       = var.environment
  map-migrated-server-id            = var.map-migrated-server-id
  region_code                       = var.region_code    
  sg_ingress_rules_cidr             = var.sg_ingress_rules_cidr 
  vpc_id                            = var.vpc_id
  retention_in_days                 = var.retention_in_days
  policy_name_msk                   = var.policy_name_msk
  policy_name_kms_secrets           = var.policy_name_kms_secrets
  enhanced_monitoring               = var.enhanced_monitoring
  msk_configuration_name            = var.msk_configuration_name
  secret_msk                        = var.secret_msk
  secret_rotation_lambda_exec_role  = var.secret_rotation_lambda_exec_role
  lambda_name                       = var.lambda_name
  deploy_lambda_file_path           = var.deploy_lambda_file_path
  secrets_msk_name                  = var.secrets_msk_name
  msk_secret_description            = var.msk_secret_description
  msk_username                      = var.msk_username
  assume_exec_role                  = var.assume_exec_role
  daas_account_number               = var.daas_account_number
}