## Please do not touch this location 
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "353991931672"
environment     = "qa"
s3_region       = "us-west-2"
s3_folder       = "share_tools"
s3_folder_type  = "iam"
s3_tfstate_file = "baas_iam.tfstate"
## Please do not touch above code 
region          = "us-west-2"

##Secrets Information
server1_secret  = "czr-baas-secret-qa-mtd-cvps-database-server1-q5HGQR"
server2_secret  = "czr-baas-secret-qa-mtd-cvps-database-server2-hQ9D5K"
snowflake       = "czr-baas-secret-qa-mtd-cvps-snowflake-hX9Fyc"

##lambda roles and policies
validate_mtd_lambda_exec_role       = "czr-baas-role-qa-lambda-mtd"
validate_mtd_lambda_exec_policy     = "czr-baas-policy-qa-lambda-mtd-secret-manager"

iam_policy_arn              = ["arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"]

##Iam role trusted relationship
aws_user_snowflake          = "arn:aws:iam::279388779427:user/d24g-s-p2su5105"
aws_iam_snowflake_user_id   = "AIA54988_SFCRole=11_FS8zC2gx9an5Hmc3nk02SRKvkuQ="