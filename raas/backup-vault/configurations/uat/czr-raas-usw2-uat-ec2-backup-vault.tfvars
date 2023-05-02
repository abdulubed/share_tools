## Terrafom tfstate configuration 
s3_bucket            =  "czr-platform-usw2-tf-state"
account              =  "488513616762"
environment          =  "uat"
s3_region            =  "us-west-2"
s3_folder            =  "share_tools"
s3_folder_type       =  "backup-vault"
s3_tfstate_file      =  "backup-vault.tfstate"
region               =  "us-west-2"
## End terrafom tfstate configuration 

aws_backup_vault        = "czr-raas-vault-usw2-uat-backup-vault"
aws_iam_role            = "czr-raas-role-usw2-uat-backup-vault"
kms_key                 = "69a52d62-3cf1-45c9-813f-f256ebaa52f1"
iam_policy_arn          = ["arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup",
                           "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores"]
