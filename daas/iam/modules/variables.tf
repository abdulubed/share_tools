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

variable "ebank_user" {
  type    = string
}

variable "ebank_policy" {
  type = string
}

variable "business_name" {
  type = string
}

variable "capability" {
  type = string
}

variable "map-migrated-server-id" {
  type = string
  default = "d-server-03vkic1y0uzm11"
}

variable "policy_name_mwaa" {
  type = string
}

variable "role_name_mwaa" {
  type = string
}

variable "s3_bucket_mwaa_dag" {
  type = string
}

variable "s3_buckets_mwaa" {
  type = list
}

variable "airflow_arn_mwaa" {
  type = string
}

variable "pos_external_user" {
  type    = string
}

variable "pos_external_policy" {
  type = string
}

variable "pos_user" {
  type    = string
}

variable "pos_policy" {
  type = string
}

variable "Freedom_pay_user" {
  type    = string
}

variable "Freedom_pay_policy" {
  type = string
}

variable "s3_bucket_freedom_pay" {
  type = string
}

variable "hosted_preprocess_lambda_exec_role" {
  type    = string
}

variable "timeworks_user" {
  type    = string
}

variable "timeworks_user_policy" {
  type = string
}

variable "s3_bucket_incoming_external" {
  type = string
}

variable "file_decrypt_lambda_exec_role" {
  type = string
}

variable "file_decrypt_lambda_exec_policy" {
  type = string
}

variable "file_decrypt_secret_arns" {
  type = list
}

variable "file_rename_lambda_exec_role" {
  type = string
}

variable "file_rename_lambda_exec_policy" {
  type = string
}

variable "jobalert_lambda_exec_role" {
  type = string
}

variable "AmazonEKSClusterAutoscalerRole" {
  type = string
}

variable "AmazonEKSClusterAutoscalerPolicy" {
  type = string
}

variable "provider_url" {
  type = string
}

variable "eks_name" {
  type = string
}

variable "role_name_flowlog" {
  type = string
}

variable "policy_name_flowlog" {
  type = string
}

variable "pdb_user" {
  type    = string
}

variable "pdb_policy" {
  type = string
}

variable "s3_bucket_pdb" {
  type = string
}

variable "sftp_file_transfer_lambda_exec_role" {
  type = string
}

variable "iam_policy_arn" {
  type = list
}

variable "job_alert_iam_policy_arn" {
  type = list
}

variable "sox_user" {
  type    = string
}

variable "sox_policy" {
  type = string
}

variable "s3_bucket_sox" {
  type = string
}

variable "igaming_user" {
  type = string
}

variable "igaming_policy" {
  type = string
}

variable "igaming_lambda_exec_role" {
  type = string
}

variable "igaming_lambda_exec_policy" {
  type = string
}

variable "shelf_user" {
  type = string
}


variable "shelf_policy" {
  type = string
}

variable "ethnicity_user" {
  type = string
}

variable "ethnicity_policy" {
  type = string
}

variable "s3_bucket_outbound" {
  type = string
}

variable "ethnicity_lambda_role" {
  type = string
}

variable "ethnicity_lambda_policy" {
  type = string
}

variable "ethnicity_iam_policy_arn" {
  type = list
}
