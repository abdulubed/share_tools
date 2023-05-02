## Please do not touch this location 
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "238837397276"
environment     = "prod"
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
policy_name_mwaa        = "czr-daas-policy-prod-mwaa-environment"
role_name_mwaa          = "czr-daas-role-prod-mwaa-environment"
s3_bucket_mwaa_dag      = "czr-prod-usw2-daas-mwaa"
s3_buckets_mwaa         = [ "arn:aws:s3:::czr-prod-usw2-daas-archive",
                            "arn:aws:s3:::czr-prod-usw2-daas-archive/*",
                            "arn:aws:s3:::czr-prod-usw2-daas-inbound",
                            "arn:aws:s3:::czr-prod-usw2-daas-inbound/*",
                            "arn:aws:s3:::czr-prod-usw2-daas-inbound-sox",
                            "arn:aws:s3:::czr-prod-usw2-daas-inbound-sox/*",
                            "arn:aws:s3:::czr-prod-usw2-daas-incoming",
                            "arn:aws:s3:::czr-prod-usw2-daas-incoming/*",
                            "arn:aws:s3:::czr-prod-usw2-daas-inprogress",
                            "arn:aws:s3:::czr-prod-usw2-daas-inprogress/*"
                            ]
airflow_arn_mwaa        = "czr-daas-airflow-usw2-prod-mwaa"

# ebank user detals #
ebank_user = "czr-daas-user-prod-sftp-incoming-external-ebank"
ebank_policy = "czr-daas-policy-prod-incoming-external-ebank"

# International Properties User Setup
pos_external_user       = "czr-daas-user-prod-sftp-incoming-external-pos-external"
pos_external_policy     = "czr-daas-policy-prod-incoming-external-pos-external"

# czr-daas-user-prod-sftp-incoming-external-pos
pos_user        = "czr-daas-user-prod-sftp-incoming-external-pos"
pos_policy      = "czr-daas-policy-prod-incoming-external-pos"

# czr-daas-user-prod-sftp-freedom-pay
Freedom_pay_user   = "czr-daas-user-prod-sftp-freedom-pay"
Freedom_pay_policy = "czr-daas-policy-prod-freedom-pay"
s3_bucket_freedom_pay = "czr-prod-usw2-daas-freedom-pay"

#Pdb user setup
pdb_user          = "czr-daas-user-prod-inbound-pdb"
pdb_policy        = "czr-daas-policy-prod-inbound-pdb"
s3_bucket_pdb     = "czr-prod-usw2-daas-inbound" 

hosted_preprocess_lambda_exec_role  = "czr-daas-role-prod-lambda-hosted-preprocess"

# Timeworks User Setup
timeworks_user              = "czr-daas-user-prod-sftp-incoming-external-timeworks"
timeworks_user_policy       = "czr-daas-policy-prod-incoming-external-timeworks"
s3_bucket_incoming_external = "czr-prod-usw2-daas-incoming-external"

file_decrypt_lambda_exec_role      = "czr-daas-role-prod-lambda-timeworks-file-decrypt"
file_decrypt_lambda_exec_policy    = "czr-daas-policy-prod-lambda-timeworks-file-decrypt"
file_decrypt_secret_arns           = ["arn:aws:secretsmanager:us-west-2:238837397276:secret:czr-daas-secret-prod-timeworks-decryption-key-FomA3q",
                                      "arn:aws:secretsmanager:us-west-2:238837397276:secret:czr-daas-secret-prod-timeworks-decryption-passphrase-yjZtXo" 
                                    ]
# File rename setup
file_rename_lambda_exec_role      = "czr-daas-role-prod-lambda-file-rename"
file_rename_lambda_exec_policy    = "czr-daas-policy-prod-lambda-file-rename"

# Job Alert
jobalert_lambda_exec_role          = "czr-daas-role-prod-lambda-jobalert"
job_alert_iam_policy_arn           = ["arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole",
                                      "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"]

# IAM Autoscaler setup
AmazonEKSClusterAutoscalerRole      = "AmazonEKSClusterAutoscalerRole"
AmazonEKSClusterAutoscalerPolicy    = "AmazonEKSClusterAutoscalerPolicy"
provider_url                        = "oidc.eks.us-west-2.amazonaws.com/id/2B0449EEE5E69D035FC94CCAED3F881A"
eks_name                            = "czr-prod-usw2-daas-eksclusters"

#VPC flowlogs roles/policies
role_name_flowlog          = "czr-daas-role-prod-flowlog"
policy_name_flowlog        = "czr-daas-policy-prod-flowlog"

#sftp_file_transfer
sftp_file_transfer_lambda_exec_role  = "czr-prod-usw2-lambda-s32sftp-filetransfer" 
iam_policy_arn          = ["arn:aws:iam::aws:policy/AmazonEC2FullAccess",
                           "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
                           "arn:aws:iam::aws:policy/AmazonS3FullAccess",
                           "arn:aws:iam::aws:policy/AWSLambdaExecute",
                           "arn:aws:iam::aws:policy/AmazonSNSFullAccess"]

#SOX user setup
sox_user          = "czr-daas-user-prod-sftp-incoming-external-sox"
sox_policy        = "czr-daas-policy-prod-incoming-external-sox"
s3_bucket_sox     = "czr-prod-usw2-daas-incoming-external-sox"  

## igaming user setup
igaming_user          = "czr-daas-user-prod-sftp-incoming-external-igaming"
igaming_policy        = "czr-daas-policy-prod-incoming-external-igaming"

# igaming role 
igaming_lambda_exec_role      = "czr-daas-role-prod-lambda-igaming"
igaming_lambda_exec_policy    = "czr-daas-policy-prod-lambda-igaming"

#shelf user setup
shelf_user          = "czr-daas-user-prod-sftp-incoming-external-shelf"
shelf_policy        = "czr-daas-policy-prod-incoming-external-shelf"

# ethinicity extract user
s3_bucket_outbound       = "czr-prod-usw2-daas-outbound"
ethnicity_user          = "czr-daas-user-prod-outbound-shelf-ethnicity"
ethnicity_policy        = "czr-daas-policy-prod-outbound-shelf-ethnicity"
