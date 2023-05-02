# IAM provisioning documentation

Welcome to IAM Provisioning documentation. This repo will deploy IAM with all related configuratino on your Amazon Web Services. Please follow the steps to deploy your IAM to multiple accounts. 

## Deployment
First you will need to  clone the repo
```
git clone https://github.harrahs.org/Infra-as-a-service/share_tools.git
```

```
cd baas/iam
```

After you have cloned you can create your own configuration or apply changes to existing configuration. All configurations are stored `configurations` folder see example `configurations/$Environment/czr-baas-iam-usw2-$Environment.tfvars`
```
Edit configurations to the file
vim configurations/$Environment/czr-baas-iam-usw2-$Environment.tfvars
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
source set-env.sh  configurations/$Environment/czr-baas-iam-usw2-$Environment.tfvars
terraform apply --var-file=$DATAFILE
```