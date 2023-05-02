## Please do not touch this location 
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "353991931672"
environment     = "qa"
s3_region       = "us-west-2"
s3_folder       = "share_tools"
s3_folder_type  = "lambda"
s3_tfstate_file = "file-rename.tfstate"
## Please do not touch above code

region      = "us-west-2"
lambda_name = "czr-daas-lambda-usw2-qa-file-rename"

deploy_lambda_file_path = "./czr-daas-lambda-usw2-qa-file-rename.zip"
existing_lambda_role    = "czr-daas-role-qa-lambda-file-rename"
existing_bucket_name    = "czr-qa-usw2-daas-incoming-external"