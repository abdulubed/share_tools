## Terrafom tfstate configuration 
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "121054486353"
environment     = "prod"
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
creation_token   = "czr-raas-efs-usw2-prod-common-code"

## Networking setup 
vpc_id          = "vpc-0be93057a37888aa2"
subnet_ids = [
     "subnet-0de0b4ea92c1c2d0f", 
     "subnet-0b3420413b5a7bc8f",
]
into_IA         = "AFTER_30_DAYS"
out_of_IA       = "AFTER_1_ACCESS"
associated_security_group_id = "sg-07689971a4dcf5152"
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