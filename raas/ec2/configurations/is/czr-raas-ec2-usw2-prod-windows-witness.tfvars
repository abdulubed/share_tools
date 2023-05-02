## Terrafom tfstate configuration 
s3_bucket           =  "czr-platform-usw2-tf-state"
account             =  "890317187585"
environment         =  "prod"
s3_region           =  "us-west-2"
s3_folder           =  "share_tools"
s3_folder_type      =  "ec2"
s3_tfstate_file     =  "ec2-witness.tfstate"
region              =  "us-west-2"
## End terrafom tfstate configuration 

## Ec2 instance configuration
key_pair            =  "czr-raas-keypair-usw2-prod-ec2-witness"
aws_ami             =  "ami-01f14dc60171d8d7b"
instance_type       =  "t3.medium"
application         =  "witness-win"

## Networking setup 
availability_zone       = "us-west-2c"
vpc_id                  = "vpc-0ac738c97976d4214"
subnet_id               = "subnet-066bcf4408ec2972c"
private_ip              = "10.34.18.50"
secondary_private_ips   = []
hostname                = "ENTARAASFSW1"

## Security group for windows EC2 instance
sg_ingress_rules_cidr = [
    {
        from_port   = 3389
        to_port     = 3389
        protocol    = "tcp"
        cidr_block  = ["10.0.0.0/8", "192.168.0.0/16"]
        description = "RDP Access"
    },
    {
        from_port   = 8
        to_port     = 0
        protocol    = "icmp"
        cidr_block  = ["10.0.0.0/8", "192.168.0.0/16"]
        description = "Allow ping"
    },
    {
        from_port   = 0
        to_port     = 65535
        protocol    = "tcp"
        cidr_block  = ["10.3.130.30/32","10.3.130.31/32","10.3.130.32/32","10.3.130.33/32","10.3.130.34/32","10.3.130.35/32","10.3.130.36/32","10.3.7.101/32","10.3.7.116/32","10.3.7.200/32","10.3.7.204/32","10.3.7.205/32","10.3.7.206/32","10.3.7.207/32","10.3.7.4/32","10.3.7.41/32","10.3.7.46/32"]
        description = "Tenable Scanner IPs"
    },
    {
        from_port   = 17472
        to_port     = 17472
        protocol    = "TCP"
        cidr_block  = ["10.220.100.155/32"]
        description = "Tanium Servers"
    },
    {
        from_port   = 139
        to_port     = 139
        protocol    = "TCP"
        cidr_block  = ["10.220.100.155/32"]
        description = "Tanium Servers"
    },
    {
        from_port   = 145 
        to_port     = 145 
        protocol    = "TCP"
        cidr_block  = ["10.220.100.155/32"]
        description = "Tanium Servers"
    },
    {
        from_port   = 17475 
        to_port     = 17475 
        protocol    = "TCP"
        cidr_block  = ["10.220.100.156/32"]
        description = "Tanium Servers"
    },
    {
        from_port   = 17486 
        to_port     = 17486 
        protocol    = "TCP"
        cidr_block  = ["64.141.240.11/32"]
        description = "Tanium Servers zone.ericorp.com End point"
    },
    {
        from_port   = 443  
        to_port     = 443  
        protocol    = "TCP"
        cidr_block  = ["172.31.250.227/32","172.31.250.230/32"]
        description = "Paloalto Server"
    },
    {
        from_port   = 445
        to_port     = 445
        protocol    = "TCP"
        cidr_block  = ["10.34.73.164/32","10.34.75.73/32"]
        description = "UAT SQL Server EC2s"
    },
    {
        from_port   = 445
        to_port     = 445
        protocol    = "TCP"
        cidr_block  = ["10.34.82.100/32","10.34.80.100/32"]
        description = "PROD ENTARAASSQL01A,ENTARAASSQL01B Primary Ips"
    },
    {
        from_port   = 445
        to_port     = 445
        protocol    = "TCP"
        cidr_block  = ["10.34.82.101/32","10.34.80.101/32"]
        description = "PROD ENTARAASSQL01A,ENTARAASSQL01B Cluster Ips"
    },
    {
        from_port   = 445
        to_port     = 445
        protocol    = "TCP"
        cidr_block  = ["10.34.82.102/32","10.34.80.102/32"]
        description = "PROD ENTARAASSQL01A,ENTARAASSQL01B Group listener Ips"
    }
]

sg_ingress_rules_sg_ids_self = [
     {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        description = "Self Security Group"
    }
]

sg_ingress_rules_sg_ids_others = []

# Backup 
existing_backup_vault           = "czr-raas-vault-usw2-prod-backup-vault"
existing_iam_role               = "czr-raas-role-usw2-prod-backup-vault"
backup_plan                     = "czr-raas-backup-plan-usw2-prod-ec2-witness"
daily_backup_rule               = "czr-raas-backup-rule-usw2-prod-ec2-daily"
weekly_backup_rule              = "czr-raas-backup-rule-usw2-prod-ec2-weekly"
monthly_backup_rule             = "czr-raas-backup-rule-usw2-prod-ec2-monthly"
backup_resource                 = "czr-raas-backup-selection-usw2-prod-ec2-witness"
daily_backup_schedule           = "cron(0 8 * * ? *)"  //every day
weekly_backup_schedule          = "cron(0 8 ? * MON *)" //every week
monthly_backup_schedule         = "cron(0 8 1 * ? *)" //every month
delete_after_7_days             = "4"
delete_after_8_weeks            = "14"  # delete after 2 weeks
delete_after_1_year             = "60"  # delete after 2 months

## Storage
root_device_type    =  "gp3"
root_device_size    =  "70"
encrypted           =  "true"

# Ebs volumes
additional_device_size = []
additional_device_name = []
additional_device_tag  = []

#Iam role
iam_role_name          = "czr-raas-role-prod-cluster-witness-win"
iam_profile_name       = "czr-raas-profile-prod-cluster-witness-win"
iam_policy_arn         = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]