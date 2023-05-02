## Please do not touch this location
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "353991931672"
environment     = "qa"
s3_region       = "us-west-2"
s3_folder       = "share_tools"
s3_folder_type  = "api_gateway"
s3_tfstate_file = "baas_api_gateway.tfstate"
## Please do not touch above code 

region          = "us-west-2"

api_gateway_name                = "czr-baas-api-usw2-qa-lambda-mtd"
existing_candidate_lambda       = "czr-baas-lambda-usw2-qa-candidate-mtd"
existing_validate_lambda        = "czr-baas-lambda-usw2-qa-validate-mtd"
existing_lambda_role            = "czr-baas-role-qa-lambda-mtd"