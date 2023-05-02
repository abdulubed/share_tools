# secretsmanager provisioning documentation

Welcome to secretsmanager Provisioning documentation. This repo will deploy secretsmanager with all related configuratino on your Amazon Web Services. Please follow the steps to deploy your secretsmanager to multiple accounts. Network structure like VPC, Subnets, Security groups, etc for secretsmanager are created under network_infrastructure repo.


## Deployment
First you will need to  clone the repo
```
git clone https://code.caesars-dev.com/Infra-as-a-service/share_tools.git
```

```
cd secretsmanager
```

After you have cloned you can create your own configuration or apply changes to existing configuration. All configurations are stored `configurations` folder see example `configurations/$Environment/$Environment-us-west-2_daas_secretsmanager.tfvars`
```
Edit configurations to the file
vim configurations/$Environment/$Environment-us-west-2_daas_secretsmanager.tfvars
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
source set-env.sh  configurations/$Environment/$Environment-us-west-2_daas_secretsmanager.tfvars
terraform apply --var-file=$DATAFILE
```