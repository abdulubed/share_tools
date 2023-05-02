## Terrafom tfstate configuration 
s3_bucket            =  "czr-platform-usw2-tf-state"
account              =  "890317187585"
environment          =  "prod"
s3_region            =  "us-west-2"
s3_folder            =  "share_tools"
s3_folder_type       =  "backup-vault"
s3_tfstate_file      =  "backup-vault.tfstate"
region               =  "us-west-2"
## End terrafom tfstate configuration 

aws_backup_vault        = "czr-raas-vault-usw2-prod-backup-vault"
aws_iam_role            = "czr-raas-role-usw2-prod-backup-vault"
kms_key                 = "440a24e4-3b74-4df6-8b8a-a25a4fbe2510"
iam_policy_arn          = ["arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup",
                           "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores"]
