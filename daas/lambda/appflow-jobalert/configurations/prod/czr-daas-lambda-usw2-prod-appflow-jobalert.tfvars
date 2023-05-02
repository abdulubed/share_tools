## Please do not touch this location 
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "238837397276"
environment     = "prod"
s3_region       = "us-west-2"
s3_folder       = "share_tools"
s3_folder_type  = "lambda"
s3_tfstate_file = "appflow-jobalert.tfstate"
## Please do not touch above code

region      = "us-west-2"
lambda_name = "czr-daas-lambda-usw2-prod-appflow-job-alert"

security_group_ids = [
    "sg-0421a637a9b4fa12f"
]
subnet_ids = [
    "subnet-0dd183bdd6fe98d12",
]

deploy_lambda_file_path = "./appflow.zip"
existing_lambda_role    = "czr-daas-role-prod-lambda-jobalert"
alert_cfg_file          = "s3://czr-prod-usw2-daas-processing/Alerting/Alerting_Info.json"
env                     = "DAAS_PRD"
event_name_RunReport    = "AppFlow-EndFlowRunReport"   
event_name_Deactivated  = "AppFlow-ScheduledFlowDeactivated"

