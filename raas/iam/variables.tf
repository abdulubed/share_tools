variable "account" {
  type = string
}
variable "environment" {
  type = string
}

variable "region" {
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

variable "map-migrated-server-id" {
  type = string
  default = "d-server-03vkic1y0uzm11"
}

variable "jwt_secret" {
  type = string
}
variable "database_secret" {
  type = string
}

variable "database_secret_raas_offers" {
  type = string
}

variable "strikeiron_secret" {
  type = string
}
variable "em1_secret" {
  type = string
}

variable "gms_secret" {
  type = string
}

variable "gms_guest_secret" {
  type = string
}

variable "pdb_republish_secret" {
  type = string
}

variable "kafka_secret" {
  type = string
}

variable "crypto_Secret" {
  type = string
}

variable "security_questions_limit" {
  type = string
}

variable "jwt_config" {
  type = string
}

variable "ENC_KEY" {
  type = string
}

variable "GMS_KEYS" {
  type = string
}

variable "STRIKEIRON_CREDENTIAL" {
  type = string
}

variable "role_name_flowlog" {
  type = string
}

variable "tenable_audit" {
  type = string
}

variable "lambda_enc_secret" {
  type = string
}

variable "gms_get_rg_secret" {
  type = string
}

variable "sms_secret" {
  type = string
}

variable "policy_name_flowlog" {
  type = string
}

variable "error_logger_secret" {
  type = string
}

variable "iden_encrypt_secret" {
  type = string
}

variable "existing_eks_cluster_role" {
  type = string
}

variable "eks_cluster_policy" {
  type = string
}

variable "oauthtoken" {
  type = string
}

variable "leap_auth_provider_keys" {
  type = string
}

variable "sa_get_rg_secret" {
  type = string
}