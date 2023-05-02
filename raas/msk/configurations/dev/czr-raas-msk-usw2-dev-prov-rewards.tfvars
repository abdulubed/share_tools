## Terrafom tfstate configuration 
s3_bucket           = "czr-platform-usw2-tf-state"
account             = "741762191802"
environment         = "dev"
s3_region           = "us-west-2"
s3_folder           = "share_tools"
s3_folder_type      = "msk"
s3_tfstate_file     = "kafka-msk.tfstate"
region              = "us-west-2"
## End terrafom tfstate configuration 

## Msk cluster configuration
cluster_name            = "czr-raas-msk-usw2-dev-rewards"
kafka_version           = "2.8.1"
number_of_broker_nodes  = "2"
instance_type           = "kafka.t3.small"
client_subnets          = ["subnet-0429753c2c41b0f37","subnet-089e725bbf43c4c91"]
volume_size             = "50"
application             = "msk-rewards"
enhanced_monitoring     = "PER_TOPIC_PER_PARTITION"
msk_configuration_name  = "czr-raas-msk-config-usw2-dev-rewards" 
secret_msk              = "AmazonMSK_czr-raas-secret-usw2-dev-prov-rewards-bHuxnJ"
policy_name_msk         = "czr-raas-policy-dev-msk"
policy_name_kms_secrets = "czr-raas-policy-dev-kms-secrets"

## Cloud watch 
retention_in_days = "365"

## Networking setup 
vpc_id                  = "vpc-0ed5350f99a88f1a7"

## Security group for MSK
sg_ingress_rules_cidr = [
    {
        from_port   = 2181
        to_port     = 2181
        protocol    = "TCP"
        cidr_block  = ["10.34.52.0/22"]
        description = "czr--dev-usw2-raas-vpc ZooKeeper authentication"
    }, 
    {
    
        from_port   = 9098
        to_port     = 9098
        protocol    = "TCP"
        cidr_block  = ["10.34.52.0/22"]
        description = "czr--dev-usw2-raas-vpc iam authentication"
    },
    {
        from_port   = 2181
        to_port     = 2181
        protocol    = "TCP"
        cidr_block  = ["10.34.20.0/23"]
        description = "czr-daas-vpc-usw2-dev-mwaa ZooKeeper authentication"
    }, 
    {
    
        from_port   = 9098
        to_port     = 9098
        protocol    = "TCP"
        cidr_block  = ["10.34.20.0/23"]
        description = "czr-daas-vpc-usw2-dev-mwaa iam authentication"
    }, 
    {
    
        from_port   = 9096
        to_port     = 9096
        protocol    = "TCP"
        cidr_block  = ["10.34.20.0/23"]
        description = "czr-daas-vpc-usw2-dev-mwaa scram authentication"
    }, 
    {
    
        from_port   = 9096
        to_port     = 9096
        protocol    = "TCP"
        cidr_block  = ["10.34.52.0/22"]
        description = "czr--dev-usw2-raas-vpc scram authentication"
    }  
] 

#Lambda,IAM & Secrets
lambda_name                         = "czr-raas-lambda-usw2-dev-secrets-automatic-rotation"
deploy_lambda_file_path             = "./czr-raas-lambda-usw2-dev-secres-automatic-rotation.zip"
secret_rotation_lambda_exec_role    = "czr-raas-role-dev-lambda-secret-rotation"
secrets_msk_name                    = "AmazonMSK_czr-raas-secret-usw2-dev-msk"
msk_secret_description              = "used for msk cluster"
msk_username                        = "msk_dev"
assume_exec_role                    = "czr-raas-iam-dev-msk-assume-role"
daas_account_number                 = "563814137075"


