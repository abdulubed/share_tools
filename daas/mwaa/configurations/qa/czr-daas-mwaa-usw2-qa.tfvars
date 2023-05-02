## Please do not touch this location 
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "353991931672"
environment     = "qa"
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

mwaa_environment_name   = "czr-daas-airflow-usw2-qa-mwaa"
execution_role          = "czr-daas-role-qa-mwaa-environment"
source_s3_bucket        = "czr-daas-s3-qa-mwaa"
dag_s3_path             = "dags/"
plugins_s3_path         = "plugins.zip"
requirements_s3_path    = "requirements.txt"
webserver_access_mode   = "PRIVATE_ONLY"
environment_class       = "mw1.large"
min_workers             = 2
max_workers             = 2
vpc_id                  = "vpc-082b248caf755f24c"
subnet_ids              = ["subnet-094e1e20e3f109c22","subnet-085d5cc5442dcc6c4"]
security_group_ids      = ["sg-07abd6076c7571ada"]
schedulers              = "5"