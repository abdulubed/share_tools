## Please do not touch this location 
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "574299803363"
environment     = "uat"
s3_region       = "us-west-2"
s3_folder       = "share_tools"
s3_folder_type  = "lambda"
s3_tfstate_file = "lambda-jobalert.tfstate"
## Please do not touch above code

region      = "us-west-2"
lambda_name = "czr-daas-lambda-usw2-uat-lambda-job-alert"

security_group_ids = [
    "sg-043c92a98f9141053"
]
subnet_ids = [
    "subnet-0d12a89204553d1cc"
]

deploy_lambda_file_path = "./lambda.zip"
existing_lambda_role    = "czr-daas-role-uat-lambda-jobalert"
alert_cfg_file          = "s3://czr-uat-usw2-daas-processing/Alerting/Alerting_Info.json"
env                     = "DAAS_UAT"

filter_names            = ["AppFlowFailureTrigger",
                           "Job Alert Failure Trigger",
                           "Hosted Lambda Failure Trigger",
                           "File Rename Failure Alert",
                           "Timeworks Lambda Failure Trigger"]                         
                           
filter_pattern          = "?ERROR"

source_arn              = ["arn:aws:logs:us-west-2:574299803363:log-group:/aws/lambda/czr-daas-lambda-usw2-uat-appflow-job-alert:*",
                           "arn:aws:logs:us-west-2:574299803363:log-group:/aws/lambda/czr-daas-lambda-usw2-uat-jobalert:*",
                           "arn:aws:logs:us-west-2:574299803363:log-group:/aws/lambda/czr-daas-lambda-usw2-uat-hosted-preprocess:*",
                           "arn:aws:logs:us-west-2:574299803363:log-group:/aws/lambda/czr-daas-lambda-usw2-uat-file-rename:*",
                           "arn:aws:logs:us-west-2:574299803363:log-group:/aws/lambda/czr-daas-lambda-usw2-uat-timeworks-file-decrypt:*"]

log_group_name         = ["/aws/lambda/czr-daas-lambda-usw2-uat-appflow-job-alert",
                          "/aws/lambda/czr-daas-lambda-usw2-uat-jobalert",
                          "/aws/lambda/czr-daas-lambda-usw2-uat-hosted-preprocess",
                          "/aws/lambda/czr-daas-lambda-usw2-uat-file-rename",
                          "/aws/lambda/czr-daas-lambda-usw2-uat-timeworks-file-decrypt"]