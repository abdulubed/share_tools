## Please do not touch this location 
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "741762191802"
environment     = "dev"
s3_region       = "us-west-2"
s3_folder       = "share_tools"
s3_folder_type  = "secretsmanager"
s3_tfstate_file = "raas_secretsmanager.tfstate"
## Please do not touch above code 

region          = "us-west-2"

secrets_raas_database              = "czr-raas-secret-usw2-dev-db-config"
database_description               = "Database credentials"

secrets_raas_jwt                   = "czr-raas-secret-usw2-dev-jwt-keys"
jwt_description                    = "JWT token secret keys"

secrets_raas_strikeiron            = "czr-raas-secret-usw2-dev-strikeiron-config"
strikeiron_description             = "Strikeiron API Config keys"

secrets_raas_eml                   = "czr-raas-secret-usw2-dev-eml-keys"
eml_description                    = "EML - Email service API Config keys"

secrets_raas_gms                   = "czr-raas-secret-usw2-dev-gms-key"
gms_description                    = "API Key & secret for GMS APIs"

secrets_raas_gms_guest             = "czr-raas-secret-usw2-dev-gms-create-guest-key"
gms_guest_description              = "GMS - Create guest Account API Config keys"

secrets_raas_pdb_republish         = "czr-raas-secret-usw2-dev-pdb-republish"
pdb_republish_description          = "PDB Republish API Config keys"

secrets_raas_kafka                 = "czr-raas-secret-usw2-dev-kafka-config"
kafka_description                  = "Kafka configuration Keys"

secrets_raas_security_questions_limit  = "czr-raas-secret-usw2-dev-security-questions-limit"
security_questions_limit_description   = "Security questions configurable value"

secrets_raas_aws_lambda_enc_secret     = "czr-raas-secret-usw2-dev-aws-lambda-enc-secret"
aws_lambda_enc_secret_description      = "AWS Lambda Encryption Secret key"

secrets_raas_sms_service_config        = "czr-raas-secret-usw2-dev-sms-service-config"
sms_service_config_description         = "Sms service configuration Secret key"

secrets_raas_gms_get_rg_info           = "czr-raas-secret-usw2-dev-gms-get-rg-info"
gms_get_rg_info_description            = "Gms get rg info Secret key"

secrets_raas_sa_get_rg_info           = "czr-raas-secret-usw2-dev-sa-get-rg-info"
sa_get_rg_info_description            = "standardize address info Secret key"

secrets_raas_error_logger              = "czr-raas-secret-usw2-dev-caesars-error-logger"
error_logger_description               = "Caesars Error Logger URL"

secrets_raas_gms_validate_oauthtoken    = "czr-raas-secret-usw2-dev-gms-validate-oauthtoken-key"
gms_validate_oauthtoken_description     = "Validate OAuth token Secret key"

secrets_raas_leap_auth_provider         = "czr-raas-secret-usw2-dev-leap-auth-provider-keys"
leap_auth_provider_description          = "leap auth provider keys"

secrets_raas_offers_database            = "czr-raas-offers-secret-usw2-dev-db-config"
secrets_raas_offers_database_description= "Database credentials for RaaS Offers"

## Database information
# Database values         
database_host                  =  "10.34.53.100"
db_database                    =  "CAESARS_REWARDS"
database_username              =  "rewards"
database_port                  =  "30001"

db_raas_offers_database_name   =  "UnifiedOffersService"
db_raas_offers_database_userid =  "UOSuser"

# jwt values
jwt_internal                   = "BA5DE39C5F28944DB6EA6AB599D86"
jwt_auth                       = "g5LkeyeKm1gi32ExXLJCaw"
jwt_mfa                        = "t9DQG1QALSdMwYsZOjECXw"

#strikeiron values
strikeiron_username            = "caesars@strikeiron.com"
strikeiron_url                 = "https://ws.strikeiron.com/StrikeIron/emv6Hygiene/EMV6Hygiene/VerifyEmail"

#em1 values
em1_api_key                    = "gj5s5hdxp3n64zjt4pvs6dpn"
em1_secret                     = "dbD3zdr7PE"
em1_url                        = "https://api-dev.caesars.com/v1/emails/genericEmail"

#gms_guest values
gms_guest_api_key              = "hr4cbahsg84tcxb4v7myvyqb"
gms_guest_secret               = "AED8VYHRvS"
gms_guest_url                  = "https://api-dev.caesars.com/v1/GMS/createGuestAccount"

#gms values
gms_api_key                    = "hr4cbahsg84tcxb4v7myvyqb"
gms_secret                     = "AED8VYHRvS"
gms_url                        = "https://api-dev.caesars.com/v1/GMS/createGuestAccount"
gms_optionsUrl                 = "https://api-dev.caesars.com/v2/GMS/getGuestProfileWithOptions"
gms_profileUrl                 = "https://api-dev.caesars.com/v1/GMS/authenticateUserWithProfile"
gms_completeInfoUrl            = "https://api-dev.caesars.com/v1/GMS/getGuestProfileCompleteInfo"
gms_createPasswordUrl          = "https://api-dev.caesars.com/v1/GMS/createPassword"
gms_updatePasswordUrl          = "https://api-dev.caesars.com/v1/GMS/updatePassword"
gms_updateGuestProfileUrl      = "https://api-dev.caesars.com/v1/GMS/updateGuestProfile"
gms_getPreferences             = "https://api-dev.caesars.com/v1/GMS/getPreferences"
gms_updatePreferences          = "https://api-dev.caesars.com/v1/GMS/updatePreferences"

#pdb_republish values
pdb_republish_api_key          = "gj5s5hdxp3n64zjt4pvs6dpn"
pdb_republish_secret           = "dbD3zdr7PE"
pdb_republish_url              = "https://api-dev.caesars.com/v1/PDB/GuestDataRetransmit"

#kafka values
kafka_url                      = "https://czr-raas-ec2-usw2-2b-dev-nlb-5888a0821a6264c3.elb.us-west-2.amazonaws.com:443"

#min values
min                            = "1"

#lambda-enc-secret values
crypto_secret                  = "9f6b98dcaeb32e44cf3dd60a19d45abf"
standard_string                = "3kspdk" 

#sms-service-config values
sms_auth_token_url             = "https://mc9l-xt1htn8z0l5psn4dq8mwzw4.auth.marketingcloudapis.com/v2/token"
sms_auth_grant_type            = "client_credentials"
sms_auth_client_secret         = "TSc3LzaGEHKd5CAMc0VdJWUT"
sms_auth_client_id             = "r11p37ze7dgihczp9h7ulxr7"
sms_auth_account_id            = "6253030"
sms_url                        = "https://mc9l-xt1htn8z0l5psn4dq8mwzw4.rest.marketingcloudapis.com/sms/v1/messageContact/MTE1Ojc4OjA/send"

#gms-get-rg-info values
gms_get_rg_url                 = "https://api-dev.caesars.com/v1/GMS/getRGInfo"
gms_get_rg_api_key             = "hr4cbahsg84tcxb4v7myvyqb"
gms_get_rg_secret              = "AED8VYHRvS"

#error logger values
error_logger_url               = "http://devakafkacon01.harrahs.org/errorlogging/Logger.asmx/LogError"

#gms validate oauthtoken values
gms_validate_oauthtoken_url    = "https://api-dev.caesars.com/v1/OAuth/AuthenticateToken"                 

#leap auth provider values
leap_auth_provider_url        = "https://api-dev.caesars.com/v1/leap/applicationservices/ValidateAffiliateAccountAccessToken"

#sa-get-rg-info values
sa_get_rg_url                 = "https://api-dev.caesars.com/rewards/v1/tools/standardize-address"
sa_get_rg_api_key             = "hr4cbahsg84tcxb4v7myvyqb"
sa_get_rg_secret              = "AED8VYHRvS"