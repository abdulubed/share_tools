## Please do not touch this location 
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "238837397276"
environment     = "prod"
s3_region       = "us-west-2"
s3_folder       = "share_tools"
s3_folder_type  = "mwaa"
s3_tfstate_file = "mwaa.tfstate"
## Please do not touch above code 

region          = "us-west-2"
## MWAA configurations
business_name           = "czr"
capability              = "daas"
application_code        = "mwaa"

mwaa_environment_name   = "czr-daas-airflow-usw2-prod-mwaa"
execution_role          = "czr-daas-role-prod-mwaa-environment"
source_s3_bucket        = "czr-prod-usw2-daas-mwaa"
dag_s3_path             = "dags/"
plugins_s3_path         = "plugins.zip"
requirements_s3_path    = "requirements.txt"
webserver_access_mode   = "PRIVATE_ONLY"
environment_class       = "mw1.large"
min_workers             = 5
max_workers             = 5
vpc_id                  = "vpc-0f721c76701992707"
subnet_ids              = ["subnet-059aa7d043b4ec3dc","subnet-022c5f1a41610d886"]
security_group_ids      = ["sg-04363b78e51768750"]
schedulers              = "5"