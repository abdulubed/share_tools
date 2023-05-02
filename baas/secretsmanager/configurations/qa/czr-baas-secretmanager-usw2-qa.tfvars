s3_bucket       = "czr-platform-usw2-tf-state"
account         = "353991931672"
environment     = "qa"
s3_region       = "us-west-2"
s3_folder       = "share_tools"
s3_folder_type  = "secretsmanager"
s3_tfstate_file = "baas_secretsmanager.tfstate"
## Please do not touch above code 

region          = "us-west-2"

secrets_lambda_mtd_cvps_database_server1    = "czr-baas-secret-qa-mtd-cvps-database-server1"
database_server1_description                = "secrets for baas lambda mtd database server1"

secrets_lambda_mtd_cvps_database_server2    = "czr-baas-secret-qa-mtd-cvps-database-server2"
database_server2_description                = "secrets for baas lambda mtd database server2"

secrets_lambda_mtd_cvps_snowflake           = "czr-baas-secret-qa-mtd-cvps-snowflake"
database_snowflake_description              = "secrets for baas snowflake"

## Database information
# server1 values
server1_username    = "cvpsdev1"    
server1_engine      = "sqlserver"
server1_host        = "10.3.26.79"
server1_port        = "30002"
server1_dbname      = "ivaletparc_ILV"

# server2 values
server2_username    = "CVPSDEV2"
server2_engine      = "sqlserver"
server2_host        = "10.3.78.111"
server2_port        = "30002"
server2_dbname      = "ivaletparc_ILV"

# snowflake values
snowflake_username  = "DAAS_SOX_APP_USER_QA"
snowflake_engine    = "sqlserver"
snowflake_host      = "aia54988.us-west-2.privatelink"
snowflake_port      = "5432"
snowflake_dbname    = "DAAS_QA"
snowflake_schema    = "DAAS_CORE_SOX"
snowflake_role      = "DAAS_SOX_APP_USER_QA_QA"
snowflake_warehouse = "DAAS_QA_XSMALL"
snowflake_account   = "aia54988.us-west-2.privatelink"