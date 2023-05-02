module "backup" {
  source                            = "./modules"
  s3_folder_type                    = var.s3_folder_type
  s3_tfstate_file                   = var.s3_tfstate_file
  s3_folder                         = var.s3_folder
  s3_region                         = var.s3_region
  s3_bucket                         = var.s3_bucket
  region                            = var.region
  account                           = var.account  
  environment                       = var.environment                        
  aws_backup_vault                  = var.aws_backup_vault
  aws_iam_role                      = var.aws_iam_role
  iam_policy_arn                    = var.iam_policy_arn
  kms_key                           = var.kms_key
}