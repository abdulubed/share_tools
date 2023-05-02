## Terrafom tfstate configuration 
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "046638516000"
environment     = "qa"
s3_region       = "us-west-2"
s3_folder       = "share_tools"
s3_folder_type  = "ecr"
s3_tfstate_file = "ecr.tfstate"

## End terrafom tfstate configuration 

region          = "us-west-2"
ecr_list = [
    "raas-nodejs-micro-pdb-keychain-sequence-tracker-qa",
    "raas-nodejs-micro-pdb-keychain-sync-data-monitor-qa",
    "raas-nodejs-micro-pdb-kafka-connector-qa",
    "raas-nodejs-micro-responsible-gaming-qa"
    ]
mutability                = "MUTABLE"