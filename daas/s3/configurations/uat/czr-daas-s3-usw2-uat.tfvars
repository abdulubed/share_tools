## Please do not touch this location 
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "574299803363"
environment     = "uat"
s3_region       = "us-west-2"
s3_folder       = "share_tools"
s3_folder_type  = "s3"
s3_tfstate_file = "s3.tfstate"
## Please do not touch above code 

region = "us-west-2"

bucket_list = [
    "czr-uat-usw2-daas-incoming-external",
    "czr-uat-usw2-daas-inbound",
    "czr-uat-usw2-daas-processing-sox",
    "czr-uat-usw2-daas-incoming-external-sox",
    "czr-uat-usw2-daas-inbound-sox",
    "czr-uat-usw2-daas-freedom-pay",
    "czr-uat-usw2-daas-mwaa",
    "czr-uat-usw2-daas-outbound"
]

sqs_account                             = "410456635333"
existing_bucket_name_incoming_external  = "czr-uat-usw2-daas-incoming-external"
existing_bucket_name_outbound           = "czr-uat-usw2-daas-outbound"
bucket_name_daas_processing             = "czr-uat-usw2-daas-processing"
lambda_arn_hosted_preprocess            = "czr-daas-lambda-usw2-uat-hosted-preprocess"
lambda_arn_file_decrypt                 = "czr-daas-lambda-usw2-uat-timeworks-file-decrypt"
lambda_arn_file_rename                  = "czr-daas-lambda-usw2-uat-file-rename"
lambda_arn_file_s3_to_sftp              = "czr-daas-lambda-usw2-uat-s3-to-sftp"
existing_sqs_queue_arn_snowpipe         = "sf-snowpipe-AIDAV7EI7G7CV2NISPUVX-fzD1tB5KGLF_cHJSUBAmWA"
incoming_external_objects               = ["timeworks/encrypted", "timeworks/in", "timeworks/out", "pos-external/agilysys/in", "pos-external/agilysys/out", "pos-external/chayolinq/in", "pos-external/chayolinq/out","pos-external/d365/in", "pos-external/d365/out", "pos-external/dba/in", "pos-external/dba/out", "pos-external/dubaibw/in", "pos-external/dubaibw/out", "pos-external/norfillmore/in", "pos-external/norfillmore/out", "pos-external/yardhouse/in", "pos-external/yardhouse/out", "pos-external/onprem/in", "pos-external/onprem/out", "ebank", "iGaming/in","iGaming/out","iGaming/processing","shelf/ethnicity/in","shelf/ethnicity/out","pos", "pos-archive", "pos-processing", "pos-processing-trigger/parent", "pos-processing-trigger/split"]
existing_bucket_name_inbound            = "czr-uat-usw2-daas-inbound"
inbound_objects                         = ["pdb/offer/history"]
bucket_name_mwaa                        = "czr-uat-usw2-daas-mwaa"
mwaa_bucket_objects                     = ["dags"]
lifecycle_45_days                       = ["czr-uat-usw2-daas-inbound-sox","czr-uat-usw2-daas-incoming-external-sox"]
lifecycle_60_days                       = ["czr-uat-usw2-daas-incoming-external"]
lifecycle_30_days                       = ["czr-uat-usw2-daas-inbound"]
daas_processing_objects                 = ["Alerting"]
s3_logs_objects                         = ["czr-uat-usw2-daas-incoming-external"]
bucket_name_logs                        = "czr-uat-usw2-daas-s3-logs"
lifecycle_logs_day                      = ["czr-uat-usw2-daas-s3-logs"]
lifecycle_logs_days                     = "2"
existing_bucket_name_incoming_external_sox   = "czr-uat-usw2-daas-incoming-external-sox"
incoming_external_sox_objects                = ["FreedomPay/in", "FreedomPay/encrypted", "Ticketmaster"]
lambda_arn_igaming                      = "czr-daas-lambda-usw2-uat-lambda-igaming"
lambda_arn_ethnicity                    = "czr-daas-lambda-usw2-uat-snowshelf-ethnicity"