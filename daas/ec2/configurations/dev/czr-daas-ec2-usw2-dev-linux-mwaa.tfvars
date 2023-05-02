## Terrafom tfstate configuration 
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "563814137075"
environment     = "dev"
s3_region       = "us-west-2"
s3_folder       = "share_tools"
s3_folder_type  = "ec2"
s3_tfstate_file = "ec2-airflow.tfstate"
region          = "us-west-2"
## End terrafom tfstate configuration 

## Ec2 airflow instance configuration
key_pair 			    = "czr-daas-keypair-usw2-dev-ec2-airflow"
aws_ami 			    = "ami-098e42ae54c764c35"
instance_type 		    = "t2.medium"
application 		    = "airflow"

## Networking setup 
availability_zone       = "us-west-2a"
vpc_id                  = "vpc-071f954a24efd11a3"
subnet_id               = "subnet-0a270c1e1c016d36e"
private_ip              = "10.34.20.50"
secondary_private_ips   = []
hostname                = ""

## Security group for windows EC2 instance (airflow)
sg_ingress_rules_cidr = [
    {
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_block  = ["10.0.0.0/8", "192.168.0.0/16"]
        description = "Airflow custom application"
    },
    {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_block  = ["10.0.0.0/8", "192.168.0.0/16"]
        description = "Allow ping"
    },
    {
        from_port   = 8
        to_port     = 0
        protocol    = "icmp"
        cidr_block  = ["10.0.0.0/8", "192.168.0.0/16"]
        description = "Allow ping"
    }
]

sg_ingress_rules_sg_ids_self = [
    {
        from_port   = 0
        to_port     = 65535
        protocol    = "tcp"
        description = "Self Security Group"
    }
]

sg_ingress_rules_sg_ids_others = []

# Backup 
existing_backup_vault           = "czr-daas-vault-usw2-dev-backup-vault"
existing_iam_role               = "czr-daas-role-usw2-dev-backup-vault"
backup_plan                     = "czr-daas-backup-plan-usw2-dev-ec2-airflow"
daily_backup_rule               = "czr-daas-backup-rule-usw2-dev-ec2-daily"
weekly_backup_rule              = "czr-daas-backup-rule-usw2-dev-ec2-weekly"
monthly_backup_rule             = "czr-daas-backup-rule-usw2-dev-ec2-monthly"
backup_resource                 = "czr-daas-backup-selection-usw2-dev-ec2-airflow"
daily_backup_schedule           = "cron(0 8 * * ? *)"  //every day
weekly_backup_schedule          = "cron(0 8 ? * MON *)" //every week
monthly_backup_schedule         = "cron(0 8 1 * ? *)" //every month
delete_after_7_days             = "7"
delete_after_8_weeks            = "56"  # delete after  8 weeks
delete_after_1_year             = "365"   # delete after  1 year

## Storage
root_device_type    =  "gp2"
root_device_size    =  "50"

# Ebs volumes
additional_device_size = []
additional_device_name = []
additional_device_tag  = []

#Iam role
iam_role_name               = "czr-daas-role-dev-airflow"
iam_profile_name            = "czr-daas-profile-dev-airflow"
iam_policy_arn              = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]