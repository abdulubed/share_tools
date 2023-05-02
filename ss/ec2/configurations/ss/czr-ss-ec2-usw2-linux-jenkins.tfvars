## Terrafom tfstate configuration 
s3_bucket           = "czr-platform-usw2-tf-state"
account             = "586467197160"
environment         = "ss"
s3_region           = "us-west-2"
s3_folder           = "share_tools"
s3_folder_type      = "ec2"
s3_tfstate_file     = "ec2-jenkins.tfstate"
region              = "us-west-2"
## End terrafom tfstate configuration 

## Ec2 mssql database instance configuration
key_pair            = "czr-ss-keypair-usw2-ec2-jenkins"
aws_ami             = "ami-098e42ae54c764c35"
instance_type       = "t2.xlarge"
application         = "jenkins"

## Networking setup 
availability_zone       = "us-west-2a"
vpc_id                  = "vpc-046655ff6f457e4c7"
subnet_id               = "subnet-037e935378b87ee88"

## Security group for windows EC2 instances (mssql database)
sg_ingress_rules_cidr = [
    {
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_block  = ["10.0.0.0/8", "192.168.0.0/16"]
        description = "Access to Jenkins"
    },
     {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_block  = ["10.0.0.0/8", "192.168.0.0/16"]
        description = "SSH"
    },
    {
        from_port   = 8
        to_port     = 0
        protocol    = "icmp"
        cidr_block  = ["10.0.0.0/8", "192.168.0.0/16"]
        description = "Allow ping"
    },
    {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_block  = ["10.0.0.0/8", "192.168.0.0/16"]
        description = "Allow ping"
    },
    {
        from_port   = 8082
        to_port     = 8082
        protocol    = "tcp"
        cidr_block  = ["10.0.0.0/8", "192.168.0.0/16"]
        description = "Allow ping"
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
existing_backup_vault           = "czr-ss-vault-usw2-backup-vault"
existing_iam_role               = "czr-ss-role-usw2-backup-vault"
backup_plan                     = "czr-ss-backup-plan"
daily_backup_rule               = "czr-ss-backup-rule-usw2-daily"
weekly_backup_rule              = "czr-ss-backup-rule-usw2-weekly"
monthly_backup_rule             = "czr-ss-backup-rule-usw2-monthly"
backup_resource                 = "czr-ss-backup-selection"
existing_backup_resource        = "czr-ss-backup-selection-exising-ec2s"
daily_backup_schedule           = "cron(0 8 * * ? *)"  //every day
weekly_backup_schedule          = "cron(0 8 ? * MON *)" //every week
monthly_backup_schedule         = "cron(0 8 1 * ? *)" //every month
delete_after_7_days             = "7"
delete_after_8_weeks            = "56"  # delete after  8 weeks
delete_after_1_year             = "365"   # delete after  1 year

## Storage
root_device_type    =  "gp2"
root_device_size    =  "100"

# Ebs volumes
additional_device_size = []
additional_device_name = []
additional_device_tag  = []

#Iam role
existing_iam_profile_name   = "Jenkins-Role"