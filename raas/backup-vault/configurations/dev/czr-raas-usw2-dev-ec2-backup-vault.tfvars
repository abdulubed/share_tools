## Terrafom tfstate configuration 
s3_bucket            =  "czr-platform-usw2-tf-state"
account              =  "741762191802"
environment          =  "dev"
s3_region            =  "us-west-2"
s3_folder            =  "share_tools"
s3_folder_type       =  "backup-vault"
s3_tfstate_file      =  "backup-vault.tfstate"
region               =  "us-west-2"
## End terrafom tfstate configuration 

aws_backup_vault        = "czr-raas-vault-usw2-dev-backup-vault"
aws_iam_role            = "czr-raas-role-usw2-dev-backup-vault"
kms_key                 = "dada756d-2d52-4066-94a7-15f1e6774266"
iam_policy_arn          = ["arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup",
                           "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores"]