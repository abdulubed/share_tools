## Please do not touch this location 
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "563814137075"
environment     = "dev"
s3_region       = "us-west-2"
s3_folder       = "share_tools"
s3_folder_type  = "iam"
s3_tfstate_file = "iam.tfstate"
## Please do not touch above code 
region          = "us-west-2"

## Cluster configurations
business_name           = "czr"
capability              = "daas"

# MWAA Setup
policy_name_mwaa        = "czr-daas-policy-dev-mwaa-environment"
role_name_mwaa          = "czr-daas-role-dev-mwaa-environment"
s3_bucket_mwaa_dag      = "czr-dev-usw2-daas-mwaa"
s3_buckets_mwaa         = [ "arn:aws:s3:::czr-dev-usw2-daas-archive",
                            "arn:aws:s3:::czr-dev-usw2-daas-archive/*",
                            "arn:aws:s3:::czr-dev-usw2-daas-inbound",
                            "arn:aws:s3:::czr-dev-usw2-daas-inbound/*", 
                            "arn:aws:s3:::czr-dev-usw2-daas-inbound-sox", 
                            "arn:aws:s3:::czr-dev-usw2-daas-inbound-sox/*",
                            "arn:aws:s3:::czr-dev-usw2-daas-incoming", 
                            "arn:aws:s3:::czr-dev-usw2-daas-incoming/*",
                            "arn:aws:s3:::czr-dev-usw2-daas-processing",
                            "arn:aws:s3:::czr-dev-usw2-daas-processing/*"
                            ]
airflow_arn_mwaa        = "czr-daas-airflow-usw2-dev-mwaa"

# ebank user detals #
ebank_user      = "czr-daas-user-dev-sftp-incoming-external-ebank"
ebank_policy    = "czr-daas-policy-dev-incoming-external-ebank"

# International Properties User Setup
pos_external_user   = "czr-daas-user-dev-sftp-incoming-external-pos-external"
pos_external_policy = "czr-daas-policy-dev-incoming-external-pos-external"

# czr-daas-user-dev-sftp-incoming-external-pos
pos_user   = "czr-daas-user-dev-sftp-incoming-external-pos"
pos_policy = "czr-daas-policy-dev-incoming-external-pos"

# czr-daas-user-dev-sftp-freedom-pay
Freedom_pay_user        = "czr-daas-user-dev-sftp-freedom-pay"
Freedom_pay_policy      = "czr-daas-policy-dev-freedom-pay"
s3_bucket_freedom_pay   = "czr-dev-usw2-daas-freedom-pay"

hosted_preprocess_lambda_exec_role  = "czr-daas-role-dev-lambda-hosted-preprocess"

# Timeworks User Setup
timeworks_user              = "czr-daas-user-dev-sftp-incoming-external-timeworks"
timeworks_user_policy       = "czr-daas-policy-dev-incoming-external-timeworks"
s3_bucket_incoming_external = "czr-dev-usw2-daas-incoming-external"

#Pdb user setup
pdb_user          = "czr-daas-user-dev-inbound-pdb"
pdb_policy        = "czr-daas-policy-dev-inbound-pdb"
s3_bucket_pdb     = "czr-dev-usw2-daas-inbound"

file_decrypt_lambda_exec_role   = "czr-daas-role-dev-lambda-timeworks-file-decrypt"
file_decrypt_lambda_exec_policy = "czr-daas-policy-dev-lambda-timeworks-file-decrypt"
file_decrypt_secret_arns        = ["arn:aws:secretsmanager:us-west-2:563814137075:secret:czr-daas-secret-dev-timeworks-decryption-key-EHusdk",
                                   "arn:aws:secretsmanager:us-west-2:563814137075:secret:czr-daas-secret-dev-timeworks-decryption-passphrase-AFbBWi" 
                                  ]

# File rename setup
file_rename_lambda_exec_role        = "czr-daas-role-dev-lambda-file-rename"
file_rename_lambda_exec_policy      = "czr-daas-policy-dev-lambda-file-rename"

# Job Alert
jobalert_lambda_exec_role          = "czr-daas-role-dev-lambda-jobalert"
job_alert_iam_policy_arn           = ["arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole",
                                      "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"]
# IAM Autoscaler setup
AmazonEKSClusterAutoscalerRole      = "AmazonEKSClusterAutoscalerRole"
AmazonEKSClusterAutoscalerPolicy    = "AmazonEKSClusterAutoscalerPolicy"
provider_url                        = "oidc.eks.us-west-2.amazonaws.com/id/85BCE906D4C3C958BC01CF4DE0F2F13B"
eks_name                            = "czr-dev-usw2-daas-ekscluster"

#VPC flowlogs roles/policies
role_name_flowlog          = "czr-daas-role-dev-flowlog"
policy_name_flowlog        = "czr-daas-policy-dev-flowlog"

#sftp_file_transfer
sftp_file_transfer_lambda_exec_role  = "czr-dev-usw2-lambda-s32sftp-filetransfer" 
iam_policy_arn          = ["arn:aws:iam::aws:policy/AmazonEC2FullAccess",
                           "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
                           "arn:aws:iam::aws:policy/AmazonS3FullAccess",
                           "arn:aws:iam::aws:policy/AWSLambdaExecute",
                           "arn:aws:iam::aws:policy/AmazonSNSFullAccess"]
#SOX user setup
sox_user          = "czr-daas-user-dev-sftp-incoming-external-sox"
sox_policy        = "czr-daas-policy-dev-incoming-external-sox"
s3_bucket_sox     = "czr-dev-usw2-daas-incoming-external-sox"  

## igaming user setup
igaming_user          = "czr-daas-user-dev-sftp-incoming-external-igaming"
igaming_policy        = "czr-daas-policy-dev-incoming-external-igaming"

# igaming role 
igaming_lambda_exec_role      = "czr-daas-role-dev-lambda-igaming"
igaming_lambda_exec_policy    = "czr-daas-policy-dev-lambda-igaming"

                  
## shelf user setup
shelf_user          = "czr-daas-user-dev-sftp-incoming-external-shelf"
shelf_policy        = "czr-daas-policy-dev-incoming-external-shelf"


# ethinicity extract user
s3_bucket_outbound       = "czr-dev-usw2-daas-outbound"
ethnicity_user          = "czr-daas-user-dev-outbound-shelf-ethnicity"
ethnicity_policy        = "czr-daas-policy-dev-outbound-shelf-ethnicity"

#ethnicity role
ethnicity_lambda_role             = "czr-daas-role-dev-lambda-shelf-ethnicity"
ethnicity_lambda_policy           = "czr-daas-policy-dev-shelf-ethnicity"
ethnicity_iam_policy_arn          = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]