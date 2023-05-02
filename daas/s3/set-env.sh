#!/bin/bash
echo $0
if [ "$0" = "$BASH_SOURCE" ]
then
   echo "$0: Please source this file."
   echo "e.g. source ./setenv configurations/"
   return 1
fi

if [ -z "$1" ]
then
   echo "setenv: You must provide the name of the configuration file."
   echo "e.g. source ./setenv configurations/"
   return 1
fi


# Get directory we are running from
DIR=$(pwd)
DATAFILE="$DIR/$1"
if [ ! -d "$DIR/configurations" ]; then
    echo "setenv: Must be run from the root directory of the terraform project."
    return 1
fi
if [ ! -f "$DATAFILE" ]; then
    echo "setenv: Configuration file not found: $DATAFILE"
    return 1
fi


# Get env from DATAFILE
ENVIRONMENT=$(sed -nr 's/^\s*environment\s*=\s*"([^"]*)".*$/\1/p' "$DATAFILE")
S3BUCKET=$(sed -nr 's/^\s*s3_bucket\s*=\s*"([^"]*)".*$/\1/p' "$DATAFILE")
S3BUCKETFOLDER=$(sed -nr 's/^\s*s3_folder\s*=\s*"([^"]*)".*$/\1/p' "$DATAFILE")
S3BUCKETREGION=$(sed -nr 's/^\s*s3_region\s*=\s*"([^"]*)".*$/\1/p' "$DATAFILE")
S3BUCKETTYPE=$(sed -nr 's/^\s*s3_folder_type\s*=\s*"([^"]*)".*$/\1/p' "$DATAFILE")
S3TFSTATEFILE=$(sed -nr 's/^\s*s3_tfstate_file\s*=\s*"([^"]*)".*$/\1/p' "$DATAFILE")
BASE_DOMAIN=$(sed -nr 's/^\s*base_domain\s*=\s*"([^"]*)".*$/\1/p' "$DATAFILE")
ACCOUNT=$(sed -nr 's/^\s*account\s*=\s*"([^"]*)".*$/\1/p' "$DATAFILE")


if [ -z "$ENVIRONMENT" ]
then
   echo "setenv: 'environment' variable not set in configuration file."
   return 1
fi

if [ -z "$ACCOUNT" ]
then
   echo "setenv: 'account' variable not set in configuration file."
   return 1
fi

if [ -z "$S3BUCKET" ]
then
   echo "setenv: 's3_bucket' variable not set in configuration file."
   return 1
fi

if [ -z "$S3BUCKETFOLDER" ]
then
  echo "setenv: 's3_folder' variable not set in configuration file."
  return 1
fi

if [ -z "$S3BUCKETREGION" ]
then
   echo "setenv: 's3_region' variable not set in configuration file."
   return 1
fi

if [ -z "$S3BUCKETTYPE" ]
then
   echo "setenv: 's3_folder_type' variable not set in configuration file."
   return 1
fi

if [ -z "$S3TFSTATEFILE" ]
then
   echo "setenv: 's3_tfstate_file' variable not set in configuration file."
   echo "e.g. s3_tfstate_file=\"infrastructure.tfstate\""
return 1
fi
cat << EOF > "$DIR/backend.tf"
terraform {
        required_version = "1.1.7"
        required_providers {
                aws = "4.5.0"
        }
    backend "s3" {
        bucket = "${S3BUCKET}"
        key = "state/${ACCOUNT}/${S3BUCKETREGION}/${S3BUCKETFOLDER}/${S3BUCKETTYPE}/${S3TFSTATEFILE}"
        region = "${S3BUCKETREGION}"
    }
}
EOF
cat backend.tf
if [[ -d ".terraform" ]]; then
   /bin/rm -rf '.terraform'
fi 
terraform init 