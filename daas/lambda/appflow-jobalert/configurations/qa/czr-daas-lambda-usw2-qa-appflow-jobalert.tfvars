## Please do not touch this location 
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "353991931672"
environment     = "qa"
s3_region       = "us-west-2"
s3_folder       = "share_tools"
s3_folder_type  = "lambda"
s3_tfstate_file = "appflow-jobalert.tfstate"
## Please do not touch above code

region      = "us-west-2"
lambda_name = "czr-daas-lambda-usw2-qa-appflow-job-alert"

security_group_ids = [
    "sg-019f359671ab4105d"
]
subnet_ids = [
    "subnet-0da0e8ec7c1428421",
]

deploy_lambda_file_path = "./appflow.zip"
existing_lambda_role    = "czr-daas-role-qa-lambda-jobalert"
alert_cfg_file          = "s3://czr-qa-usw2-daas-processing/Alerting/Alerting_Info.json"
env                     = "DAAS_QA"
event_name_RunReport    = "AppFlow-EndFlowRunReport"   
event_name_Deactivated  = "AppFlow-ScheduledFlowDeactivated"

