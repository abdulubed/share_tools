## Please do not touch this location 
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "563814137075"
environment     = "dev"
s3_region       = "us-west-2"
s3_folder       = "share_tools"
s3_folder_type  = "lambda"
s3_tfstate_file = "lambda-jobalert.tfstate"
## Please do not touch above code

region      = "us-west-2"
lambda_name = "czr-daas-lambda-usw2-dev-lambda-job-alert"

security_group_ids = [
    "sg-0920225c5f318402a"
]
subnet_ids = [
    "subnet-03aea8b1749ae34f2",
]

deploy_lambda_file_path = "./lambda.zip"
existing_lambda_role    = "czr-daas-role-dev-lambda-jobalert"
alert_cfg_file          = "s3://czr-dev-usw2-daas-processing/Alerting/alerting_info.json"
env                     = "DAAS_DEV"

filter_names            = ["AppFlowFailureTrigger",
                           "Job Alert Failure Trigger",
                           "Hosted Lambda Failure Trigger",
                           "File Rename Failure Alert",
                           "Timeworks Lambda Failure Trigger"]
                           
filter_pattern          = "?ERROR"

source_arn              = ["arn:aws:logs:us-west-2:563814137075:log-group:/aws/lambda/czr-daas-lambda-usw2-dev-appflow-job-alert:*",
                           "arn:aws:logs:us-west-2:563814137075:log-group:/aws/lambda/czr-daas-lambda-usw2-dev-jobalert:*",
                           "arn:aws:logs:us-west-2:563814137075:log-group:/aws/lambda/czr-daas-lambda-usw2-dev-hosted-preprocess:*",
                           "arn:aws:logs:us-west-2:563814137075:log-group:/aws/lambda/czr-daas-lambda-usw2-dev-file-rename:*",
                           "arn:aws:logs:us-west-2:563814137075:log-group:/aws/lambda/czr-daas-lambda-usw2-dev-timeworks-file-decrypt:*"]

log_group_name         = ["/aws/lambda/czr-daas-lambda-usw2-dev-appflow-job-alert",
                          "/aws/lambda/czr-daas-lambda-usw2-dev-jobalert",
                          "/aws/lambda/czr-daas-lambda-usw2-dev-hosted-preprocess",
                          "/aws/lambda/czr-daas-lambda-usw2-dev-file-rename",
                          "/aws/lambda/czr-daas-lambda-usw2-dev-timeworks-file-decrypt"]