## Please do not touch this location 
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "563814137075"
environment     = "dev"
s3_region       = "us-west-2"
s3_folder       = "share_tools"
s3_folder_type  = "lambda"
s3_tfstate_file = "jobalert.tfstate"
## Please do not touch above code

region      = "us-west-2"
lambda_name = "czr-daas-lambda-usw2-dev-jobalert"

vpc_id = "vpc-0a308101fedfbcb3d"
security_group_ids = [
    "sg-0920225c5f318402a"
]
subnet_ids = [
    "subnet-03aea8b1749ae34f2",
]

existing_lambda_role    = "czr-daas-role-dev-lambda-jobalert"
existing_api_role       = "daas_api_integration"

deploy_lambda_file_path = "./czr-daas-lambda-usw2-dev-jobalert.zip"