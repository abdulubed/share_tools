# IAM provisioning documentation

Welcome to IAM Provisioning documentation. This repo will deploy IAM with all related configuratino on your Amazon Web Services. Please follow the steps to deploy your IAM to multiple accounts. 

## Deployment
First you will need to  clone the repo
```
git clone https://code.caesars-dev.com/Infra-as-a-service/share_tools.git
```

```
cd IAM
```

After you have cloned you can create your own configuration or apply changes to existing configuration. All configurations are stored `configurations` folder see example `configurations/$Environment/$Environment-us-west-2_daas_IAM.tfvars`
```
Edit configurations to the file
vim configurations/$Environment/$Environment-us-west-2_daas_IAM.tfvars
```

After you have the configuration you need to get access to Jenkins EC2
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
source set-env.sh  configurations/$Environment/$Environment-us-west-2_daas_IAM.tfvars
terraform apply --var-file=$DATAFILE
```