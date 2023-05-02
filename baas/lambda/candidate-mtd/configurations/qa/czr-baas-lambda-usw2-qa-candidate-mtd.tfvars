## Please do not touch this location 
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "353991931672"
environment     = "qa"
s3_region       = "us-west-2"
s3_folder       = "share_tools"
s3_folder_type  = "lambda"
s3_tfstate_file = "candidate.tfstate"
## Please do not touch above code

region                  = "us-west-2"
lambda_name             = "czr-baas-lambda-usw2-qa-candidate-mtd"
existing_lambda_role    = "czr-baas-role-qa-lambda-mtd"

vpc_id = "vpc-050932129e184bdfd"
security_group_ids = [
    "sg-095e85150fd97d85f"
]
subnet_ids = [
    "subnet-0f284ec050ffc601c"
]

deploy_candidate_lambda_file_path   = "./czr-baas-lambda-usw2-qa-candidate-mtd.zip"
existing_layer_name                 = "nodejslayer"