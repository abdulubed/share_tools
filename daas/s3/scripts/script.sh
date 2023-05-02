# declare -a StringArray=(
# "pos-archive/",
#  "pos-processing-trigger/",
#  "pos-processing-trigger/parent/",
#  "pos-processing-trigger/split/",
#  "pos-processing/",
#  "pos/",
#  "ebank/")

# declare -a StringArray=("pos-processing/")


# touch file 
# for val in ${StringArray[@]}; do
#     aws s3 cp file s3://czr-prod-usw2-daas-incoming-external/$val
# done






for item in $(cat $2); do
    # aws s3api put-object --bucket "$1" --key "/pos-archive/$item"
    aws s3 cp file "s3://$1/pos-archive/last"
    # echo "s3://$1/pos-archive/${item}"
done


## PROD 
# bash script.sh czr-prod-usw2-daas-incoming-external test.txt 


## bash script.sh czr-uat-usw2-daas-incoming-external-sox uat-daas-create-folder.txt

## DEV 
# bash script.sh czr-dev-usw2-daas-incoming-external test.txt 

# bash script.sh czr-prod-usw2-daas-incoming-external need-to-delete.txt


# Bucket - czr-dev-usw2-daas-incoming-external
# Folder - pos-archive-1

## UAT
# Create folder in a bucket
# aws s3api put-object --bucket czr-uat-usw2-daas-incoming-external --key ebank/