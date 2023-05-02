# share_tools documentions

Welcome to Share Tools documentation. This repository will deploy S3 Buckets for DAAS UAT on top of your Amazon Web Services. Please follow the steps to deploy S3.

## Deployment
First you will need to  clone the repo
```
git clone https://code.caesars-dev.com/Infra-as-a-service/share_tools.git
```

After that you can create your configurations to create S3 Buckets. All configuration details will be stored in `configurations/UAT/daas-uat-s3.tfvars`

```
vi configurations/UAT/daas-uat-s3.tfvars
```

After you have the configuration you need to get access to AWS
```
export AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID"
export AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY"
export AWS_SESSION_TOKEN="$AWS_SESSION_TOKEN"
```

Verify the access by running 
```
aws sts get-caller-identity
```

After you see the command is successfully finished you can go ahead and deploy it
```
source ./set-env.sh  configurations/UAT/daas-uat-s3.tfvars
export AWS_DEFAULT_REGION="us-west-2"
terraform apply --var-file=$DATAFILE -auto-approve=true
```