## Please do not touch this location 
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "563814137075"
environment     = "dev"
s3_region       = "us-west-2"
s3_folder       = "share_tools"
s3_folder_type  = "lambda"
s3_tfstate_file = "sftp.tfstate"
## Please do not touch above code

region      = "us-west-2"
lambda_name = "czr-daas-lambda-usw2-dev-s3-to-sftp"

deploy_lambda_file_path = "./s32sftp.zip"
existing_lambda_role    = "czr-dev-usw2-lambda-s32sftp-filetransfer"
existing_bucket_name    = "czr-dev-usw2-daas-outbound"
secret_name             = "arn:aws:secretsmanager:us-west-2:563814137075:secret:czr-daas-secret-dev-sftp-file-transfer-ViRv4f"
sns_topic               = "arn:aws:sns:us-west-2:563814137075:czr-daas-dev-usw2-error-notify"