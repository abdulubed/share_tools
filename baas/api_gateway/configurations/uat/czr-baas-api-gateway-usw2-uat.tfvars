## Please do not touch this location 
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "574299803363"
environment     = "uat"
s3_region       = "us-west-2"
s3_folder       = "share_tools"
s3_folder_type  = "api_gateway"
s3_tfstate_file = "baas_api_gateway.tfstate"
## Please do not touch above code 

region          = "us-west-2"

api_gateway_name                = "czr-baas-api-usw2-uat-lambda-mtd"
existing_candidate_lambda       = "czr-baas-lambda-usw2-uat-candidate-mtd"
existing_validate_lambda        = "czr-baas-lambda-usw2-uat-validate-mtd"
existing_lambda_role            = "czr-baas-role-uat-lambda-mtd"