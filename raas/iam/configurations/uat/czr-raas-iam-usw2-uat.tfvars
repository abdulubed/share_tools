## Please do not touch this location 
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "488513616762"
environment     = "uat"
s3_region       = "us-west-2"
s3_folder       = "share_tools"
s3_folder_type  = "iam"
s3_tfstate_file = "raas_iam.tfstate"
## Please do not touch above code 
region          = "us-west-2"

##roles and policies
existing_eks_cluster_role   = "czr-uat-usw2-raas-ekscluster-node-role"
eks_cluster_policy          = "czr-raas-policy-uat-eks-cluster-secret-manager"

##Secrets Information
jwt_secret              = "czr-raas-secret-usw2-uat-jwt-keys-0sumBP"
database_secret         = "czr-raas-secret-usw2-uat-db-config-pbK0tH"
database_secret_raas_offers = "czr-raas-offers-secret-usw2-uat-db-config-0Gcojm"
strikeiron_secret       = "czr-raas-secret-usw2-uat-strikeiron-config-zqk1eP"
em1_secret              = "czr-raas-secret-usw2-uat-eml-keys-cqrz8P"
gms_secret              = "czr-raas-secret-usw2-uat-gms-key-jo4WrO"
gms_guest_secret        = "czr-raas-secret-usw2-uat-gms-create-guest-key-0mBZGi"
pdb_republish_secret    = "czr-raas-secret-usw2-uat-pdb-republish-nkuqMi"
kafka_secret            = "czr-raas-secret-usw2-uat-kafka-config-pbK0tH"
security_questions_limit= "czr-raas-secret-usw2-uat-security-questions-limit-3mPSDM"
lambda_enc_secret       = "czr-raas-secret-usw2-uat-aws-lambda-enc-secret-WobvkN"
gms_get_rg_secret       = "czr-raas-secret-usw2-uat-sms-service-config-vm1aYN"
sms_secret              = "czr-raas-secret-usw2-uat-gms-get-rg-info-WobvkN"
error_logger_secret     = "czr-raas-secret-usw2-uat-caesars-error-logger-77Ow0o"
tenable_audit           = "/svc/credentials/tenable-audit-Om6yzV"
crypto_Secret           = "cryptoSecret-zVJX6P"
jwt_config              = "jwt_config-6a5Yjy"
ENC_KEY                 = "ENC_KEY-SXaSHg"
GMS_KEYS                = "GMS_KEYS-WiVQkl"
STRIKEIRON_CREDENTIAL   = "STRIKEIRON_CREDENTIAL-yjebZe"
iden_encrypt_secret     = "czr-raas-secret-usw2-uat-iden-encrypt-secret-kDQiiy"
role_name_flowlog       = "czr-raas-role-uat-flowlog"
policy_name_flowlog     = "czr-raas-policy-uat-flowlog"
oauthtoken              = "czr-raas-secret-usw2-uat-gms-validate-oauthtoken-key-PkjmRA"
leap_auth_provider_keys = "czr-raas-secret-usw2-uat-leap-auth-provider-keys-j3ATbD"
sa_get_rg_secret        = "czr-raas-secret-usw2-uat-sa-get-rg-info-XYB9aJ"