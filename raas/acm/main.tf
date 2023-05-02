module "acm" {
  source                                        = "./modules"
  region                                        = var.region
  account                                       = var.account
  s3_folder                                     = var.s3_folder
  s3_region                                     = var.s3_region
  s3_folder_type                                = var.s3_folder_type
  s3_bucket                                     = var.s3_bucket
  s3_tfstate_file                               = var.s3_tfstate_file
  environment                                   = var.environment
  map-migrated-server-id                        = var.map-migrated-server-id
  domain_name                                   = var.domain_name
  validation_method                             = var.validation_method
  acm_certificate_name                          = var.acm_certificate_name
}