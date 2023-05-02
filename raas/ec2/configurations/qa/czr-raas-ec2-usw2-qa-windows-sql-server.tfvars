## Terrafom tfstate configuration 
s3_bucket           = "czr-platform-usw2-tf-state"
account             = "046638516000"
environment         = "qa"
s3_region           = "us-west-2"
s3_folder           = "share_tools"
s3_folder_type      = "ec2"
s3_tfstate_file     = "ec2-mssql-database.tfstate"
region              = "us-west-2"
## End terrafom tfstate configuration 

## Ec2 mssql database instance configuration
key_pair            = "czr-raas-keypair-usw2-qa-ec2-mssql-database"
aws_ami             = "ami-0db150645c6d57e58"
instance_type       = "r5b.large"
application         = "sql-server-win"

## Networking setup 
availability_zone       = "us-west-2a"
vpc_id                  = "vpc-0798639ebb26eaaa7"
subnet_id               = "subnet-09d4322f7867a7647"
private_ip              = "10.34.67.50"
secondary_private_ips   = []
hostname                = "QATARAASSQL01"

## Security group for windows EC2 instances (mssql database)
sg_ingress_rules_cidr = [
    {
        from_port   = 3389
        to_port     = 3389
        protocol    = "tcp"
        cidr_block  = ["10.0.0.0/8", "192.168.0.0/16"]
        description = "RDP Access"
    },
     {
        from_port   = 30001
        to_port     = 30001
        protocol    = "tcp"
        cidr_block  = ["10.0.0.0/8", "192.168.0.0/16"]
        description = "Access to MSSQL Server Port"
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
        from_port   = 0
        to_port     = 65535
        protocol    = "tcp"
        cidr_block  = ["10.34.75.73/32"]
        description = "UAT SQL Server"
    },
    {
        from_port   = 0
        to_port     = 65535
        protocol    = "tcp"
        cidr_block  = ["10.34.72.0/22"]
        description = "For Testing network share"
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
        cidr_block  = ["10.34.53.100/32","10.34.73.164/32","10.34.75.73/32"]
        description = "DEV & UAT SQL Server EC2s"
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

sg_ingress_rules_sg_ids_others = [
    {
    from_port   = 30001
    to_port     = 30001
    protocol    = "tcp"
    source_security_group_id = "sg-01f3772ce3b2f36e9"
    description = "Cluster security group - czr-qa-usw2-raas-ekscluster"
  },
   {
    from_port   = 30001
    to_port     = 30001
    protocol    = "tcp"
    source_security_group_id = "sg-0437b450d06f84324"
    description = "Additional security groups - czr-qa-usw2-raas-ekscluster"
  }
]

# Backup 
existing_backup_vault           = "czr-raas-vault-usw2-qa-backup-vault"
existing_iam_role               = "czr-raas-role-usw2-qa-backup-vault"
backup_plan                     = "czr-raas-backup-plan-usw2-qa-ec2-sql-server"
daily_backup_rule               = "czr-raas-backup-rule-usw2-qa-ec2-daily"
weekly_backup_rule              = "czr-raas-backup-rule-usw2-qa-ec2-weekly"
monthly_backup_rule             = "czr-raas-backup-rule-usw2-qa-ec2-monthly"
backup_resource                 = "czr-raas-backup-selection-usw2-qa-ec2-sql-server"
daily_backup_schedule           = "cron(0 8 * * ? *)"  //every day
weekly_backup_schedule          = "cron(0 8 ? * MON *)" //every week
monthly_backup_schedule         = "cron(0 8 1 * ? *)" //every month
delete_after_7_days             = "7"
delete_after_8_weeks            = "56"  # delete after  8 weeks
delete_after_1_year             = "365"   # delete after  1 year

## Storage
root_device_type    =  "gp3"
root_device_size    =  "100"

# Ebs volumes
additional_device_size = ["25","100","50","50","100"]
additional_device_name = ["xvdf","xvdh","xvdb","xvdp","xvdc"]
additional_device_tag  = ["S-Sytem", "F-Data", "L-Log", "T-Temp", "Y-Backup"]

#Iam role
iam_role_name               = "czr-raas-role-qa-sql-server-win"
iam_profile_name            = "czr-raas-profile-qa-sql-server-win"
iam_policy_arn              = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
