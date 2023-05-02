## Please do not touch this location 
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "353991931672"
environment     = "qa"
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
policy_name_mwaa        = "czr-daas-policy-qa-mwaa-environment"
role_name_mwaa          = "czr-daas-role-qa-mwaa-environment"
s3_bucket_mwaa_dag      = "czr-daas-s3-qa-mwaa"
s3_buckets_mwaa         = [ "arn:aws:s3:::czr-qa-usw2-daas-archive",
                            "arn:aws:s3:::czr-qa-usw2-daas-archive/*",
                            "arn:aws:s3:::czr-qa-usw2-daas-inbound",
                            "arn:aws:s3:::czr-qa-usw2-daas-inbound/*",
                            "arn:aws:s3:::czr-qa-usw2-daas-inbound-sox",
                            "arn:aws:s3:::czr-qa-usw2-daas-inbound-sox/*",
                            "arn:aws:s3:::czr-qa-usw2-daas-incoming",
                            "arn:aws:s3:::czr-qa-usw2-daas-incoming/*",
                            "arn:aws:s3:::czr-qa-usw2-daas-inprogress",
                            "arn:aws:s3:::czr-qa-usw2-daas-inprogress/*"
                            ]
airflow_arn_mwaa        = "czr-daas-airflow-usw2-qa-mwaa"

# ebank user detals #
ebank_user = "czr-daas-user-qa-sftp-incoming-external-ebank"
ebank_policy = "czr-daas-policy-qa-incoming-external-ebank"

# International Properties User Setup
pos_external_user       = "czr-daas-user-qa-sftp-incoming-external-pos-external"
pos_external_policy     = "czr-daas-policy-qa-incoming-external-pos-external"

# czr-daas-user-qa-sftp-incoming-external-pos
pos_user        = "czr-daas-user-qa-sftp-incoming-external-pos"
pos_policy      = "czr-daas-policy-qa-incoming-external-pos"

# czr-daas-user-qa-sftp-freedom-pay
Freedom_pay_user   = "czr-daas-user-qa-sftp-freedom-pay"
Freedom_pay_policy = "czr-daas-policy-qa-freedom-pay"
s3_bucket_freedom_pay = "czr-qa-usw2-daas-freedom-pay"

hosted_preprocess_lambda_exec_role  = "czr-daas-role-qa-lambda-hosted-preprocess"

# Timeworks User Setup
timeworks_user              = "czr-daas-user-qa-sftp-incoming-external-timeworks"
timeworks_user_policy       = "czr-daas-policy-qa-incoming-external-timeworks"
s3_bucket_incoming_external = "czr-qa-usw2-daas-incoming-external"

#Pdb user setup
pdb_user          = "czr-daas-user-qa-inbound-pdb"
pdb_policy        = "czr-daas-policy-qa-inbound-pdb"
s3_bucket_pdb     = "czr-qa-usw2-daas-inbound"

file_decrypt_lambda_exec_role      = "czr-daas-role-qa-lambda-timeworks-file-decrypt"
file_decrypt_lambda_exec_policy    = "czr-daas-policy-qa-lambda-timeworks-file-decrypt"
file_decrypt_secret_arns           = ["arn:aws:secretsmanager:us-west-2:353991931672:secret:czr-daas-secret-qa-timeworks-decryption-key-vgMpCX",
                                    "arn:aws:secretsmanager:us-west-2:353991931672:secret:czr-daas-secret-qa-timeworks-decryption-passphrase-DeqMTU" 
                                   ]

# File rename setup
file_rename_lambda_exec_role      = "czr-daas-role-qa-lambda-file-rename"
file_rename_lambda_exec_policy    = "czr-daas-policy-qa-lambda-file-rename"

# Job Alert
jobalert_lambda_exec_role          = "czr-daas-role-qa-lambda-jobalert"
job_alert_iam_policy_arn           = ["arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole",
                                      "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"]
# IAM Autoscaler setup
AmazonEKSClusterAutoscalerRole      = "AmazonEKSClusterAutoscalerRole"
AmazonEKSClusterAutoscalerPolicy    = "AmazonEKSClusterAutoscalerPolicy"
provider_url                        = "oidc.eks.us-west-2.amazonaws.com/id/9DED21AE3D3D4FD7EECBA03393D39B11"
eks_name                            = "czr-qa-usw2-daas-eks"

#VPC flowlogs roles/policies
role_name_flowlog          = "czr-daas-role-qa-flowlog"
policy_name_flowlog        = "czr-daas-policy-qa-flowlog"

#sftp_file_transfer
sftp_file_transfer_lambda_exec_role  = "czr-qa-usw2-lambda-s32sftp-filetransfer" 
iam_policy_arn          = ["arn:aws:iam::aws:policy/AmazonEC2FullAccess",
                           "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
                           "arn:aws:iam::aws:policy/AmazonS3FullAccess",
                           "arn:aws:iam::aws:policy/AWSLambdaExecute",
                           "arn:aws:iam::aws:policy/AmazonSNSFullAccess"]                          

#SOX user setup
sox_user          = "czr-daas-user-qa-sftp-incoming-external-sox"
sox_policy        = "czr-daas-policy-qa-incoming-external-sox"
s3_bucket_sox     = "czr-qa-usw2-daas-incoming-external-sox" 

## igaming user setup
igaming_user          = "czr-daas-user-qa-sftp-incoming-external-igaming"
igaming_policy        = "czr-daas-policy-qa-incoming-external-igaming"

# igaming role 
igaming_lambda_exec_role      = "czr-daas-role-qa-lambda-igaming"
igaming_lambda_exec_policy    = "czr-daas-policy-qa-lambda-igaming"
                  
## shelf user setup
shelf_user          = "czr-daas-user-qa-sftp-incoming-external-shelf"
shelf_policy        = "czr-daas-policy-qa-incoming-external-shelf"

# ethinicity extract user
s3_bucket_outbound       = "czr-qa-usw2-daas-outbound"
ethnicity_user          = "czr-daas-user-qa-outbound-shelf-ethnicity"
ethnicity_policy        = "czr-daas-policy-qa-outbound-shelf-ethnicity"

#ethnicity role
ethnicity_lambda_role             = "czr-daas-role-qa-lambda-shelf-ethnicity"
ethnicity_lambda_policy           = "czr-daas-policy-qa-shelf-ethnicity"
ethnicity_iam_policy_arn          = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]
                  
