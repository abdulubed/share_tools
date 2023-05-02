## Please do not touch this location 
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "353991931672"
environment     = "qa"
s3_region       = "us-west-2"
s3_folder       = "share_tools"
s3_folder_type  = "lambda"
s3_tfstate_file = "sftp.tfstate"
## Please do not touch above code

region      = "us-west-2"
lambda_name = "czr-daas-lambda-usw2-qa-s3-to-sftp"

deploy_lambda_file_path = "./s32sftp.zip"
existing_lambda_role    = "czr-qa-usw2-lambda-s32sftp-filetransfer"
existing_bucket_name    = "czr-qa-usw2-daas-outbound"
secret_name             = "arn:aws:secretsmanager:us-west-2:353991931672:secret:czr-daas-secret-qa-sftp-file-transfer-b6ld65"
sns_topic               = "arn:aws:sns:us-west-2:353991931672:czr-daas-qa-usw2-error-notify"