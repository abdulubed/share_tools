## Terrafom tfstate configuration 
s3_bucket            =  "czr-platform-usw2-tf-state"
account              =  "586467197160"
environment          =  "ss"
s3_region            =  "us-west-2"
s3_folder            =  "share_tools"
s3_folder_type       =  "backup-vault"
s3_tfstate_file      =  "backup-vault.tfstate"
region               =  "us-west-2"
## End terrafom tfstate configuration 

aws_backup_vault        = "czr-ss-vault-usw2-backup-vault"
aws_iam_role            = "czr-ss-role-usw2-backup-vault"
kms_key                 = "91c033de-3ff1-4e9b-8862-5ae2877c0b36"
iam_policy_arn          = ["arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup",
                           "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores"]