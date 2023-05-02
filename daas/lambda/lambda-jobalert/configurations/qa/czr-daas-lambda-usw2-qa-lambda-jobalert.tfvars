## Please do not touch this location 
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "353991931672"
environment     = "qa"
s3_region       = "us-west-2"
s3_folder       = "share_tools"
s3_folder_type  = "lambda"
s3_tfstate_file = "lambda-jobalert.tfstate"
## Please do not touch above code

region      = "us-west-2"
lambda_name = "czr-daas-lambda-usw2-qa-lambda-job-alert"

security_group_ids = [
    "sg-019f359671ab4105d"
]
subnet_ids = [
    "subnet-0da0e8ec7c1428421"
]

deploy_lambda_file_path = "./lambda.zip"
existing_lambda_role    = "czr-daas-role-qa-lambda-jobalert"
alert_cfg_file          = "s3://czr-qa-usw2-daas-processing/Alerting/Alerting_Info.json"
env                     = "DAAS_QA"

filter_names            = ["AppFlowFailureTrigger",
                           "Job Alert Failure Trigger",
                           "Hosted Lambda Failure Trigger",
                           "File Rename Failure Alert",
                           "Timeworks Lambda Failure Trigger"]                         
                           
filter_pattern          = "?ERROR"

source_arn              = ["arn:aws:logs:us-west-2:353991931672:log-group:/aws/lambda/czr-daas-lambda-usw2-qa-appflow-job-alert:*",
                           "arn:aws:logs:us-west-2:353991931672:log-group:/aws/lambda/czr-daas-lambda-usw2-qa-jobalert:*",
                           "arn:aws:logs:us-west-2:353991931672:log-group:/aws/lambda/czr-daas-lambda-usw2-qa-hosted-preprocess:*",
                           "arn:aws:logs:us-west-2:353991931672:log-group:/aws/lambda/czr-daas-lambda-usw2-qa-file-rename:*",
                           "arn:aws:logs:us-west-2:353991931672:log-group:/aws/lambda/czr-daas-lambda-usw2-qa-timeworks-file-decrypt:*"]

log_group_name         = ["/aws/lambda/czr-daas-lambda-usw2-qa-appflow-job-alert",
                          "/aws/lambda/czr-daas-lambda-usw2-qa-jobalert",
                          "/aws/lambda/czr-daas-lambda-usw2-qa-hosted-preprocess",
                          "/aws/lambda/czr-daas-lambda-usw2-qa-file-rename",
                          "/aws/lambda/czr-daas-lambda-usw2-qa-timeworks-file-decrypt"]