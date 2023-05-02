## Terrafom tfstate configuration 
s3_bucket           =  "czr-platform-usw2-tf-state"
account             =  "121054486353"
environment         =  "prod"
s3_region           =  "us-west-2"
s3_folder           =  "share_tools"
s3_folder_type      =  "nlb"
s3_tfstate_file     =  "nlb-sql-server.tfstate"
region              =  "us-west-2"
## End terrafom tfstate configuration 

internal        = true
deletion_protection_enabled = true
lb_name         = "czr-raas-nlb-usw2-prod-sqlserver"   //Max length is 32 characters
tg_name         = "czr-raas-tg-usw2-prod-sqlserver"

instance_list   = [
    {instance="10.34.82.102", port="30001"},
    {instance="10.34.80.102", port="30001"}
]

lbport          = 30001
target_type     = "ip"
tgport          = 30001

## Networking setup 
vpc_id          = "vpc-0be93057a37888aa2"
subnet_ids      = ["subnet-0de0b4ea92c1c2d0f", "subnet-0b3420413b5a7bc8f"]
## End networking setup 