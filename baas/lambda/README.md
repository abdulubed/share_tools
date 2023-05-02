# Lambda provisioning documentation
Welcome to Lambda Provisioning documentation. This repo will deploy Lambda with all related configuration on your Amazon Web Services. Please follow the steps to deploy your Lambda to multiple accounts.

# Lambda execution steps
1.create network infrastructure
2.create secrets manager
3.create iam role and policies 
4.create layers 
5.create lambdas
6.create api-gateways
7.change trusted relationship in iam role (aws_user_snowflake and aws_iam_snowflake_user_id)

 
1.create network infrastructure
-------------------------------
Welcome to network infrastructure Provisioning documentation. This repo will deploy network infrastructure with all related configuration on your Amazon Web Services. Please follow the steps to deploy your network infrastructure to multiple accounts. 

## Deployment
First you will need to  clone the repo
```
git clone https://github.harrahs.org/Infra-as-a-service/network_infrastructure.git
```

```
cd baas/network_infrastructure/
```

After you have cloned you can create your own configuration or apply changes to existing configuration. All configurations are stored `configurations` folder see example `configurations/$Environment/czr-baas-network-usw2-$Environment-mtd.tfvars.tfvars`
```
Edit configurations to the file
vim configurations/$Environment/czr-baas-network-usw2-$Environment-mtd.tfvars.tfvars
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
source set-env.sh  configurations/$Environment/czr-baas-network-usw2-$Environment-mtd.tfvars.tfvars
terraform apply --var-file=$DATAFILE
```

2.create secrets manager
------------------------
# secretsmanager provisioning documentation

Welcome to secretsmanager Provisioning documentation. This repo will deploy secretsmanager with all related configuratino on your Amazon Web Services. Please follow the steps to deploy your secretsmanager to multiple accounts.


## Deployment
First you will need to  clone the repo
```
git clone https://github.harrahs.org/Infra-as-a-service/share_tools.git
```

```
cd baas/secretsmanager
```

After you have cloned you can create your own configuration or apply changes to existing configuration. All configurations are stored `configurations` folder see example `configurations/$Environment/czr-baas-secretmanager-usw2-$Environment.tfvars`
```
Edit configurations to the file
vim configurations/$Environment/czr-baas-secretmanager-usw2-$Environment.tfvars
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
source set-env.sh  configurations/$Environment/czr-baas-secretmanager-usw2-$Environment.tfvars
terraform apply --var-file=$DATAFILE
```
3.create iam role and policies 
------------------------------
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
4.create layers 
---------------
# lambda layers provisioning documentation

Welcome to lambda layers Provisioning documentation. This repo will deploy lambda layers with all related configuratino on your Amazon Web Services. Please follow the steps to deploy your lambda layers to multiple accounts. 

## Deployment
First you will need to  clone the repo
```
git clone https://github.harrahs.org/Infra-as-a-service/share_tools.git
```

```
cd baas/layers
```

After you have cloned you can create your own configuration or apply changes to existing configuration. All configurations are stored `configurations` folder see example `configurations/$Environment/czr-baas-layer-usw2-$Environment-nodejs-layer.tfvars`
```
Edit configurations to the file
vim configurations/$Environment/czr-baas-layer-usw2-$Environment-nodejs-layer.tfvars
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
source set-env.sh  configurations/$Environment/czr-baas-layer-usw2-$Environment-nodejs-layer.tfvars
terraform apply --var-file=$DATAFILE
```

5.create lambdas
----------------
# lambda candidate-mtd and validate-mtd provisioning documentation

Welcome to lambda candidate-mtd and validate-mtd Provisioning documentation. This repo will deploy lambda candidate-mtd and validate-mtd with all related configuratino on your Amazon Web Services. Please follow the steps to deploy your lambda candidate-mtd and validate-mtd to multiple accounts. 

## Deployment
First you will need to  clone the repo
```
git clone https://github.harrahs.org/Infra-as-a-service/share_tools.git
```

```
cd baas/lambda/candidate-mtd
cd baas/lambda/validate-mtd
```

After you have cloned you can create your own configuration or apply changes to existing configuration. All configurations are stored `configurations` folder see example `configurations/$Environment/czr-baas-lambda-usw2-$Environment-candidate-mtd.tfvars, configurations/$Environment/czr-baas-lambda-usw2-$Environment-validate-mtd.tfvars`
```
Edit configurations to the file
vim configurations/$Environment/czr-baas-lambda-usw2-$Environment-candidate-mtd.tfvars
vim configurations/$Environment/czr-baas-lambda-usw2-$Environment-validate-mtd.tfvars
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
source set-env.sh  configurations/$Environment/ czr-baas-lambda-usw2-$Environment-candidate-mtd.tfvars
terraform apply --var-file=$DATAFILE
source set-env.sh  configurations/$Environment/ czr-baas-lambda-usw2-$Environment-validate-mtd.tfvars
terraform apply --var-file=$DATAFILE
```
6.create api-gateways
---------------------
# api_gateway provisioning documentation

Welcome to api_gateway Provisioning documentation. This repo will deploy api_gateway with all related configuration on your Amazon Web Services. Please follow the steps to deploy your api_gateway to multiple accounts.

## Deployment
First you will need to  clone the repo
```
git clone https://github.harrahs.org/Infra-as-a-service/share_tools.git
```

```
cd baas/api_gateway
```

After you have cloned you can create your own configuration or apply changes to existing configuration. All configurations are stored `configurations` folder see example `configurations/$Environment/$Environment-us-west-2_baas_api_gateway.tfvars`
```
Edit configurations to the file
vim configurations/$Environment/czr-baas-api-gateway-usw2-$Environment.tfvars
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
source set-env.sh  configurations/$Environment/czr-baas-api-gateway-usw2-$Environment.tfvars
terraform apply --var-file=$DATAFILE
```

7.change trusted relationship in iam role
-----------------------------------------
# IAM provisioning documentation
After creation of api gateways we need to chante iam role trusted relationship (aws_user_snowflake and aws_iam_snowflake_user_id) in tfvars 

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
