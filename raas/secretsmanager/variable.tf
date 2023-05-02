variable "account" {}

variable "environment" {
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

variable "secrets_raas_database" {}
variable "database_description" {}

variable "secrets_raas_offers_database" {}
variable "secrets_raas_offers_database_description" {}

variable "secrets_raas_jwt" {}
variable "jwt_description" {}

variable "secrets_raas_strikeiron" {}
variable "strikeiron_description" {}

variable "secrets_raas_eml" {}
variable "eml_description" {}

variable "secrets_raas_gms" {}
variable "gms_description" {}

variable "secrets_raas_gms_guest" {}
variable "gms_guest_description" {}

variable "secrets_raas_pdb_republish" {}
variable "pdb_republish_description" {}

variable "secrets_raas_kafka" {}
variable "kafka_description" {}

variable "secrets_raas_security_questions_limit" {}
variable "security_questions_limit_description" {}

variable "secrets_raas_aws_lambda_enc_secret" {}
variable "aws_lambda_enc_secret_description" {}

variable "secrets_raas_sms_service_config" {}
variable "sms_service_config_description" {}

variable "secrets_raas_gms_get_rg_info" {}
variable "gms_get_rg_info_description" {}

variable "secrets_raas_sa_get_rg_info" {}
variable "sa_get_rg_info_description" {}

variable "secrets_raas_error_logger" {}
variable "error_logger_description" {}

variable "secrets_raas_gms_validate_oauthtoken" {}
variable "gms_validate_oauthtoken_description" {}

variable "secrets_raas_leap_auth_provider" {}
variable "leap_auth_provider_description" {}

variable "database_username" {
  type = string
}
variable "database_host" {
  type = string
}
variable "db_database" { 
  type = string
}
variable "database_port" {
  type = string
}
variable "db_raas_offers_database_name" {
  type = string
}
variable "db_raas_offers_database_userid" {
  type = string
}
variable "jwt_internal" {
  type = string
}
variable "jwt_auth" {
  type = string
}
variable "jwt_mfa" {
  type = string
}

variable "strikeiron_username" {
  type = string
}
variable "strikeiron_url" {
  type = string
}

variable "em1_api_key" {
  type = string
}
variable "em1_secret" {
  type = string
}
variable "em1_url" {
  type = string
}

variable "gms_api_key" {
  type = string
}
variable "gms_secret" {
  type = string
}
variable "gms_url" {
  type = string
}
variable "gms_optionsUrl" {
  type = string
}
variable "gms_profileUrl" {
  type = string
}
variable "gms_completeInfoUrl" {
  type = string
}
variable "gms_createPasswordUrl" {
  type = string
}
variable "gms_updatePasswordUrl" {
  type = string
}
variable "gms_updateGuestProfileUrl" {
  type = string
}  
variable "gms_getPreferences" {
  type = string
}
variable "gms_updatePreferences" {
  type = string
}

variable "gms_guest_api_key" {
  type = string
}
variable "gms_guest_secret" {
  type = string
}
variable "gms_guest_url" {
  type = string
}

variable "pdb_republish_api_key" {
  type = string
}
variable "pdb_republish_secret" {
  type = string
}
variable "pdb_republish_url" {
  type = string
}

variable "kafka_url" {
  type = string
}

variable "min" {
  type = string
}

variable "crypto_secret" {
  type = string
}
variable "standard_string" {
  type = string
}

variable "sms_auth_token_url" {
  type = string
}
variable "sms_auth_grant_type" {
  type = string
}
variable "sms_auth_client_secret" { 
  type = string
}
variable "sms_auth_client_id" {
  type = string
}
variable "sms_auth_account_id" { 
  type = string
}
variable "sms_url" {
  type = string
}

variable "gms_get_rg_url" {
  type = string
}
variable "gms_get_rg_api_key" { 
  type = string
}
variable "gms_get_rg_secret" {
  type = string
}

variable "error_logger_url" {
  type = string
}

variable "gms_validate_oauthtoken_url" {
  type = string
}

variable "leap_auth_provider_url" {
  type = string
}

variable "sa_get_rg_url" {
  type = string
}
variable "sa_get_rg_api_key" { 
  type = string
}
variable "sa_get_rg_secret" {
  type = string
}
