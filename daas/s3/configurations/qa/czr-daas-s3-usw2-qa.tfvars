## Please do not touch this location 
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "353991931672"
environment     = "qa"
s3_region       = "us-west-2"
s3_folder       = "share_tools"
s3_folder_type  = "s3"
s3_tfstate_file = "s3.tfstate"
## Please do not touch above code 

region = "us-west-2"

bucket_list = [
    "czr-qa-usw2-daas-incoming-external",
    "czr-qa-usw2-daas-inbound",
    "czr-qa-usw2-daas-processing-sox",
    "czr-qa-usw2-daas-incoming-external-sox",
    "czr-qa-usw2-daas-inbound-sox",
    "czr-qa-usw2-daas-freedom-pay",
    "czr-daas-s3-qa-mwaa",
    "czr-qa-usw2-daas-outbound"
    ]

sqs_account                             = "279388779427"
existing_bucket_name_incoming_external  = "czr-qa-usw2-daas-incoming-external"
existing_bucket_name_outbound           = "czr-qa-usw2-daas-outbound"
lambda_arn_hosted_preprocess            = "czr-daas-lambda-usw2-qa-hosted-preprocess"
bucket_name_daas_processing             = "czr-qa-usw2-daas-processing"
daas_processing_objects                 = ["Alerting"]
lambda_arn_file_decrypt                 = "czr-daas-lambda-usw2-qa-timeworks-file-decrypt"
lambda_arn_file_rename                  = "czr-daas-lambda-usw2-qa-file-rename"
lambda_arn_file_s3_to_sftp              = "czr-daas-lambda-usw2-qa-s3-to-sftp"
existing_sqs_queue_arn_snowpipe         = "sf-snowpipe-AIDAUCDG6OORS7RKW2VUA-4GM4_kEErV936WfhUGLAgQ"
incoming_external_objects               = ["timeworks/encrypted", "timeworks/in", "timeworks/out", "pos-external/agilysys/in", "pos-external/agilysys/out", "pos-external/chayolinq/in", "pos-external/chayolinq/out","pos-external/d365/in", "pos-external/d365/out", "pos-external/dba/in", "pos-external/dba/out", "pos-external/dubaibw/in", "pos-external/dubaibw/out", "pos-external/norfillmore/in", "pos-external/norfillmore/out", "pos-external/yardhouse/in", "pos-external/yardhouse/out", "pos-external/onprem/in", "pos-external/onprem/out", "ebank", "iGaming/in","iGaming/out","iGaming/processing","shelf/ethnicity/in", "shelf/ethnicity/out", "pos", "pos-archive", "pos-processing", "pos-processing-trigger/parent", "pos-processing-trigger/split"]
existing_bucket_name_inbound            = "czr-qa-usw2-daas-inbound"
inbound_objects                         = ["pdb/offer/history"]
bucket_name_mwaa                        = "czr-daas-s3-qa-mwaa"
mwaa_bucket_objects                     = ["dags"]
lifecycle_45_days                       = ["czr-qa-usw2-daas-inbound-sox","czr-qa-usw2-daas-incoming-external-sox"]
lifecycle_60_days                       = ["czr-qa-usw2-daas-incoming-external"]
lifecycle_30_days                       = ["czr-qa-usw2-daas-inbound"]
s3_logs_objects                         = ["czr-qa-usw2-daas-incoming-external"]
bucket_name_logs                        = "czr-qa-usw2-daas-s3-logs"
lifecycle_logs_day                      = ["czr-qa-usw2-daas-s3-logs"]
lifecycle_logs_days                     = "2"
lambda_arn_igaming                      = "czr-daas-lambda-usw2-qa-lambda-igaming"
existing_bucket_name_incoming_external_sox   = "czr-qa-usw2-daas-incoming-external-sox"
incoming_external_sox_objects                = ["FreedomPay/in", "FreedomPay/encrypted", "Ticketmaster"]
lambda_arn_ethnicity                         = "czr-daas-lambda-usw2-qa-snowshelf-ethnicity"


    