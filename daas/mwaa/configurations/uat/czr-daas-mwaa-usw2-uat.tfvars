## Please do not touch this location 
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "574299803363"
environment     = "uat"
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

mwaa_environment_name   = "czr-daas-airflow-usw2-uat-mwaa"
execution_role          = "czr-daas-role-uat-mwaa-environment"
source_s3_bucket        = "czr-uat-usw2-daas-mwaa"
dag_s3_path             = "dags/"
plugins_s3_path         = "plugins.zip"
requirements_s3_path    = "requirements.txt"
webserver_access_mode   = "PRIVATE_ONLY"
environment_class       = "mw1.large"
min_workers             = 5
max_workers             = 5
vpc_id                  = "vpc-087be7f613b8cb698"
subnet_ids              = ["subnet-0df0c2b93b5031a84","subnet-0b9917904887e258f"]
security_group_ids      = ["sg-00e045340143c411a"]
schedulers              = "5"