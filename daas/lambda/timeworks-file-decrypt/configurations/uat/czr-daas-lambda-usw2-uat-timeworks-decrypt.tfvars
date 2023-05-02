## Please do not touch this location 
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "574299803363"
environment     = "uat"
s3_region       = "us-west-2"
s3_folder       = "share_tools"
s3_folder_type  = "lambda"
s3_tfstate_file = "timeworks-file-decrypt.tfstate"
## Please do not touch above code 

region      = "us-west-2"
lambda_name = "czr-daas-lambda-usw2-uat-timeworks-file-decrypt"

deploy_lambda_file_path         = "./czr-daas-lambda-usw2-uat-timeworks-file-decrypt.zip"
existing_lambda_role            = "czr-daas-role-uat-lambda-timeworks-file-decrypt"
existing_bucket_name            = "czr-uat-usw2-daas-incoming-external"
secret_name_passphrase_arn      = "czr-daas-secret-uat-timeworks-decryption-passphrase-yACpyX"
secret_name_decryption_key_arn  = "czr-daas-secret-uat-timeworks-decryption-key-PdimVK"
