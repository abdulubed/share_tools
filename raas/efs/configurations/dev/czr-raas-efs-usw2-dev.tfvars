## Terrafom tfstate configuration 
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "741762191802"
environment     = "dev"
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
vpc_id          = "vpc-03ae556cfafb88d3f"
subnet_ids = [
     "subnet-05322910d7d04e94c", 
     "subnet-0258d4129c8bcfb45",
]
into_IA         = "AFTER_30_DAYS"
out_of_IA       = "AFTER_1_ACCESS"
associated_security_group_id = "sg-0d054714fad03bd83"
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