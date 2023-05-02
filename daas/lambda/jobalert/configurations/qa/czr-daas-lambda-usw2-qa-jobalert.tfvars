## Please do not touch this location 
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "353991931672"
environment     = "qa"
s3_region       = "us-west-2"
s3_folder       = "share_tools"
s3_folder_type  = "lambda"
s3_tfstate_file = "jobalert.tfstate"
## Please do not touch above code

region      = "us-west-2"
lambda_name = "czr-daas-lambda-usw2-qa-jobalert"

vpc_id = "vpc-050932129e184bdfd"
security_group_ids = [
    "sg-019f359671ab4105d"
]
subnet_ids = [
    "subnet-0da0e8ec7c1428421",
]

existing_lambda_role    = "czr-daas-role-qa-lambda-jobalert"
existing_api_role       = "DaaS-Snowflake-Lambda-Access-Role"

deploy_lambda_file_path = "./czr-daas-lambda-usw2-qa-jobalert.zip"