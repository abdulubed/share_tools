module "ecr" {
  source                                        = "./modules/ecr"
  region                                        = var.region
  account                                       = var.account
  s3_folder                                     = var.s3_folder
  s3_region                                     = var.s3_region
  s3_folder_type                                = var.s3_folder_type
  s3_bucket                                     = var.s3_bucket
  s3_tfstate_file                               = var.s3_tfstate_file
  environment                                   = var.environment
  ecr_list                                      = var.ecr_list
  mutability                                    = var.mutability
  map-migrated-server-id                        = var.map-migrated-server-id
}
