## Please do not touch this location 
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "563814137075"
environment     = "dev"
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

mwaa_environment_name   = "czr-daas-airflow-usw2-dev-mwaa"
execution_role          = "czr-daas-role-dev-mwaa-environment"
source_s3_bucket        = "czr-dev-usw2-daas-mwaa"
dag_s3_path             = "dags/"
plugins_s3_path         = "plugins.zip"
requirements_s3_path    = "requirements.txt"
webserver_access_mode   = "PRIVATE_ONLY"
environment_class       = "mw1.large"
min_workers             = 1
max_workers             = 1
vpc_id                  = "vpc-071f954a24efd11a3"
subnet_ids              = ["subnet-0a270c1e1c016d36e","subnet-013bf4bed077039d9"]
security_group_ids      = ["sg-0f6d702cbaacbd6c1"]
schedulers              = "2"