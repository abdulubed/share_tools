## Please do not touch this location 
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "238837397276"
environment     = "prod"
s3_region       = "us-west-2"
s3_folder       = "share_tools"
s3_folder_type  = "lambda"
s3_tfstate_file = "jobalert.tfstate"
## Please do not touch above code

region      = "us-west-2"
lambda_name = "czr-daas-lambda-usw2-prod-jobalert"

vpc_id = "vpc-0a1956bf1e8e353b4"
security_group_ids = [
    "sg-0421a637a9b4fa12f"
]
subnet_ids = [
    "subnet-0dd183bdd6fe98d12",
]

existing_lambda_role    = "czr-daas-role-prod-lambda-jobalert"
existing_api_role       = "DaaS-Snowflake-Lambda-Access-Role"

deploy_lambda_file_path = "./czr-daas-lambda-usw2-prod-jobalert.zip"