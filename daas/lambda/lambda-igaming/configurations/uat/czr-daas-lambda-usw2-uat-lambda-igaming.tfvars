## Please do not touch this location 
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "574299803363"
environment     = "uat"
s3_region       = "us-west-2"
s3_folder       = "share_tools"
s3_folder_type  = "lambda"
s3_tfstate_file = "igaming.tfstate"
## Please do not touch above code

region      = "us-west-2"
lambda_name = "czr-daas-lambda-usw2-uat-lambda-igaming"

deploy_lambda_file_path       = "./czr-daas-lambda-usw2-qa-igaming.zip"
existing_lambda_role          = "czr-daas-role-uat-lambda-igaming"
existing_bucket_name          = "czr-uat-usw2-daas-incoming-external"
existing_layer_name           = ["pandas_layer", "openpyxl_layer"]
