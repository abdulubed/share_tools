## Terrafom tfstate configuration 
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "741762191802"
environment     = "dev"
s3_region       = "us-west-2"
s3_folder       = "share_tools"
s3_folder_type  = "acm"
s3_tfstate_file = "acm.tfstate"

## End terrafom tfstate configuration 

region          = "us-west-2"

domain_name          = [
    "api-dev2.raas.caesars-dev.com"
]
validation_method    = "DNS"
acm_certificate_name = "czr-raas-api-usw2-dev-rewards-app"