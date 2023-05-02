## Please do not touch this location 
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "563814137075"
environment     = "dev"
s3_region       = "us-west-2"
s3_folder       = "share_tools"
s3_folder_type  = "lambda"
s3_tfstate_file = "candidate.tfstate"
## Please do not touch above code

region                  = "us-west-2"
lambda_name             = "czr-baas-lambda-usw2-dev-candidate-mtd"
existing_lambda_role    = "czr-baas-role-dev-lambda-mtd"

vpc_id = "vpc-0a308101fedfbcb3d"
security_group_ids = [
    "sg-0ccb9076a32431b29"
]
subnet_ids = [
    "subnet-0b4b5231dab0e9dd8"
]

deploy_candidate_lambda_file_path   = "./czr-baas-lambda-usw2-dev-candidate-mtd.zip"
existing_layer_name                 = "nodejslayer"