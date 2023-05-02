## Please do not touch this location 
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "574299803363"
environment     = "uat"
s3_region       = "us-west-2"
s3_folder       = "share_tools"
s3_folder_type  = "lambda"
s3_tfstate_file = "jobalert.tfstate"
## Please do not touch above code

region      = "us-west-2"
lambda_name = "czr-daas-lambda-usw2-uat-jobalert"

vpc_id = "vpc-0fa9a112ab8afd853"
security_group_ids = [
        "sg-043c92a98f9141053"
]
subnet_ids = [
    "subnet-0d12a89204553d1cc",
]

existing_lambda_role    = "czr-daas-role-uat-lambda-jobalert"
existing_api_role       = "DaaS-Snowflake-Lambda-Access-Role"

deploy_lambda_file_path = "./czr-daas-lambda-usw2-uat-jobalert.zip"