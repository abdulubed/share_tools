## Please do not touch this location 
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "563814137075"
environment     = "dev"
s3_region       = "us-west-2"
s3_folder       = "share_tools"
s3_folder_type  = "iam"
s3_tfstate_file = "baas_iam.tfstate"
## Please do not touch above code 
region          = "us-west-2"

##Secrets Information
server1_secret  = "czr-baas-secret-dev-mtd-cvps-database-server1-7sLnEu"
server2_secret  = "czr-baas-secret-dev-mtd-cvps-database-server2-DE88Wc"
snowflake       = "czr/baas/snowflake-ymPOgc"

##lambda roles and policies
validate_mtd_lambda_exec_role       = "czr-baas-role-dev-lambda-mtd"
validate_mtd_lambda_exec_policy     = "czr-baas-policy-dev-lambda-mtd-secret-manager"

iam_policy_arn              = ["arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"]

##Iam role trusted relationship
aws_user_snowflake          = "arn:aws:iam::279388779427:user/d24g-s-p2su5105"
aws_iam_snowflake_user_id   = "AIA54988_SFCRole=11_4o5m8pfTk2auR0UqPLK9JReqXnw="