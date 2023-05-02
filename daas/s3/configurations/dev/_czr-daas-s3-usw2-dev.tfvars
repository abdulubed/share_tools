## Please do not touch this location 
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "563814137075"
environment     = "dev"
s3_region       = "us-west-2"
s3_folder       = "share_tools"
s3_folder_type  = "s3"
s3_tfstate_file = "s3.tfstate"
## Please do not touch above code 

region = "us-west-2"

bucket_list = [
    "czr-dev-usw2-daas-freedom-pay",
    "czr-dev-usw2-daas-incoming-external"
    ]

sqs_account                             = "279388779427"
existing_bucket_name_incoming_external  = "czr-dev-usw2-daas-incoming-external"
lambda_arn_hosted_preprocess            = "czr-daas-lambda-usw2-dev-hosted-preprocess"
lambda_arn_file_decrypt                 = "czr-daas-lambda-usw2-timeworks-file-decrypt"
lambda_arn_file_rename                  = "czr-daas-lambda-usw2-file-rename"
existing_sqs_queue_arn_snowpipe         = "sf-snowpipe-AIDAUCDG6OORS7RKW2VUA-4GM4_kEErV936WfhUGLAgQ"
incoming_external_objects = ["timeworks/encrypted", "timeworks/in", "timeworks/out"]

/*
bucket_list = [
    "czr-uat-usw2-daas-incoming-external",
    "czr-uat-usw2-daas-processing",
    "czr-uat-usw2-daas-inbound",
    "czr-uat-usw2-daas-processing-sox",
    "czr-uat-usw2-daas-incoming-external-sox",
    "czr-uat-usw2-daas-inbound-sox"
]
*/