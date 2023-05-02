## Please do not touch this location 
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "238837397276"
environment     = "prod"
s3_region       = "us-west-2"
s3_folder       = "share_tools"
s3_folder_type  = "lambda"
s3_tfstate_file = "candidate.tfstate"
## Please do not touch above code

region                  = "us-west-2"
lambda_name             = "czr-baas-lambda-usw2-prod-candidate-mtd"
existing_lambda_role    = "czr-baas-role-prod-lambda-mtd"

vpc_id = "vpc-0a1956bf1e8e353b4"
security_group_ids = [
    "TBD"
]
subnet_ids = [
    "TBD"
]

deploy_candidate_lambda_file_path   = "./czr-baas-lambda-usw2-prod-candidate-mtd.zip"
existing_layer_name                 = "nodejslayer"
