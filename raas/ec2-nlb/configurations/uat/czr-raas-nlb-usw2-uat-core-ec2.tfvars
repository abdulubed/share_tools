## Terrafom tfstate configuration 
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "488513616762"
environment     = "uat"
s3_region       = "us-west-2"
s3_folder       = "share_tools"
s3_folder_type  = "nlb"
s3_tfstate_file = "nlb.tfstate"
## End terrafom tfstate configuration 

region          = "us-west-2"
internal        = true
deletion_protection_enabled = false
lb_name         = "raas--uat-nlb-lb-kafka-tf"
tg_name         = "raas-uat-aws-nlb-tg-kafka-tf"
instance_list   = [
    {instance="i-0f68728e3d60b53cb",port="8082"}
]
lbport          = 443
tgport          = 443
//target_type     = "ip"

## Networking setup 
vpc_id          = "vpc-0ecae39fab919b590"
subnet_ids      = [ "subnet-0335d11252a6ca001", "subnet-09a95e7440750bbad" ]


## End networking setup 
