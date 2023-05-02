## Terrafom tfstate configuration 
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "488513616762"
environment     = "uat"
s3_region       = "us-west-2"
s3_folder       = "share_tools"
s3_folder_type  = "efs"
s3_tfstate_file = "efs.tfstate"

## End terrafom tfstate configuration 

region          = "us-west-2"
encrypted       = "true"
performance_mode = "generalPurpose"
throughput_mode  = "bursting"
map-migrated     = "d-server-03vkic1y0uzm11"

## Networking setup 
vpc_id          = "vpc-0ecae39fab919b590"
subnet_ids = [
     "subnet-09a95e7440750bbad", 
     "subnet-0335d11252a6ca001",
]
into_IA         = "AFTER_30_DAYS"
out_of_IA       = "AFTER_1_ACCESS"
associated_security_group_id = "sg-0cb0a4b38e9d3b0d1"
efs_ingress_rules = [
    {
        from_port   = 2049
        to_port     = 2049
        protocol    = "tcp"
        cidr_block  = "10.0.0.0/8"
        description = "efs access"
    },
    {
        from_port   = 2049
        to_port     = 2049
        protocol    = "tcp"
        cidr_block  = "192.168.0.0/16"
        description = "efs access"
    },
]

## End networking setup 