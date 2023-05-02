## Please do not touch this location 
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "238837397276"
environment     = "prod"
s3_region       = "us-west-2"
s3_folder       = "share_tools"
s3_folder_type  = "lambda"
s3_tfstate_file = "lambda-hosted-preprocess.tfstate"
## Please do not touch above code 

region = "us-west-2"
lambda_name             = "czr-daas-lambda-usw2-prod-hosted-preprocess"

deploy_lambda_file_path = "./czr-daas-lambda-usw2-prod-hosted-preprocess.zip"
existing_lambda_role    = "czr-daas-role-prod-lambda-hosted-preprocess"
existing_bucket_name    = "czr-prod-usw2-daas-incoming-external"
