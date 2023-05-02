## Terrafom tfstate configuration 
s3_bucket           =  "czr-platform-usw2-tf-state"
account             =  "488513616762"
environment         =  "uat"
s3_region           =  "us-west-2"
s3_folder           =  "share_tools"
s3_folder_type      =  "nlb"
s3_tfstate_file     =  "nlb-sql-server.tfstate"
region              =  "us-west-2"
## End terrafom tfstate configuration 

internal        = true
deletion_protection_enabled = true
lb_name         = "czr-raas-nlb-usw2-uat-sql-server"
tg_name         = "czr-raas-tg-usw2-uat-sql-server"

instance_list   = [
    {instance="10.34.74.30", port="30001"},
    {instance="10.34.72.195", port="30001"}
]

lbport          = 30001
target_type     = "ip"
tgport          = 30001

## Networking setup 
vpc_id          = "vpc-0ecae39fab919b590"
subnet_ids      = ["subnet-0335d11252a6ca001", "subnet-09a95e7440750bbad"]
## End networking setup 