## Terrafom tfstate configuration 
s3_bucket            =  "czr-platform-usw2-tf-state"
account              =  "563814137075"
environment          =  "dev"
s3_region            =  "us-west-2"
s3_folder            =  "share_tools"
s3_folder_type       =  "backup-vault"
s3_tfstate_file      =  "backup-vault.tfstate"
region               =  "us-west-2"
## End terrafom tfstate configuration 

aws_backup_vault        = "czr-daas-vault-usw2-dev-backup-vault"
aws_iam_role            = "czr-daas-role-usw2-dev-backup-vault"
kms_key                 = "6fa9f5dc-fd85-47e9-8975-9a4378db0a80"
iam_policy_arn          = ["arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup",
                           "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores"]