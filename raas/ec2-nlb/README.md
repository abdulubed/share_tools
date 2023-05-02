# EC2 provisioning documentation

Welcome to EC2 Provisioning documentation. This repo will deploy EC2 with VPC, SG, Subnet, ebs volume on top of your Amazon Web Services. Please follow the steps to deploy your EC2 to multiple accounts


## Deployment
First you will need to  clone the repo
```
git clone https://code.caesars-dev.com/Infra-as-a-service/share_tools.git
```


After you have cloned you can create your own configuration or apply changes to existing configuration. All configurations are stored `configurations` folder see example `configurations/TOOLS/sandbox_us-west-2_core_ec2.tfvars`
```
vim configurations/TOOLS/sandbox_us-west-2_core_ec2.tfvars
```


After you have the configuration you need to get access to EC2
```
export AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID"
export AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY"
```

Verify the access by running 
```
aws sts get-caller-identity
```


After you see the command is successfully finished you can go ahead and deploy it
```
source set-env.sh  configurations/TOOLS/sandbox_us-west-2_core_ec2.tfvars
terraform apply --var-file=$DATAFILE
```
