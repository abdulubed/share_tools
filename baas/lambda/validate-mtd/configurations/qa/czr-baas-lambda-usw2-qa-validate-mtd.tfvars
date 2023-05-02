## Please do not touch this location 
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "353991931672"
environment     = "qa"
s3_region       = "us-west-2"
s3_folder       = "share_tools"
s3_folder_type  = "lambda"
s3_tfstate_file = "validate.tfstate"
## Please do not touch above code

region                          = "us-west-2"
lambda_name                     = "czr-baas-lambda-usw2-qa-validate-mtd"
existing_lambda_role            = "czr-baas-role-qa-lambda-mtd"
snowflake_database              = "DAAS_QA"
snowflake_key_store_arn_secret  = "czr-baas-secret-qa-mtd-cvps-snowflake-hX9Fyc"

vpc_id = "vpc-050932129e184bdfd"
security_group_ids = [
    "sg-095e85150fd97d85f"
]
subnet_ids = [
    "subnet-0f284ec050ffc601c"
]

deploy_validate_lambda_file_path    = "./czr-baas-lambda-usw2-qa-validate-mtd.zip"
existing_layer_name                          = "nodejslayer"