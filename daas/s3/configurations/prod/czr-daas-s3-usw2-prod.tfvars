## Please do not touch this location 
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "238837397276"
environment     = "prod"
s3_region       = "us-west-2"
s3_folder       = "share_tools"
s3_folder_type  = "s3"
s3_tfstate_file = "s3.tfstate"
## Please do not touch above code 

region = "us-west-2"

bucket_list = [
    "czr-prod-usw2-daas-incoming-external",
    "czr-prod-usw2-daas-incoming-external-sox",
    "czr-prod-usw2-daas-inbound",
    "czr-prod-usw2-daas-inbound-sox",
    "czr-prod-usw2-daas-logs",
    "czr-prod-usw2-daas-airflowdags",
    "czr-prod-usw2-daas-freedom-pay",
    "czr-prod-usw2-daas-mwaa",
    "czr-prod-usw2-daas-outbound"
]

sqs_account                             = "410456635333"
existing_bucket_name_incoming_external  = "czr-prod-usw2-daas-incoming-external"
lambda_arn_hosted_preprocess            = "czr-daas-lambda-usw2-prod-hosted-preprocess"
bucket_name_daas_processing             = "czr-prod-usw2-daas-processing"
lambda_arn_file_decrypt                 = "czr-daas-lambda-usw2-prod-timeworks-file-decrypt"
lambda_arn_file_rename                  = "czr-daas-lambda-usw2-prod-file-rename"
existing_sqs_queue_arn_snowpipe         = "sf-snowpipe-AIDAV7EI7G7CV2NISPUVX-fzD1tB5KGLF_cHJSUBAmWA"
incoming_external_objects               = ["timeworks/encrypted", "timeworks/in", "timeworks/out", "pos-external/agilysys/in", "pos-external/agilysys/out", "pos-external/chayolinq/in", "pos-external/chayolinq/out","pos-external/d365/in", "pos-external/d365/out", "pos-external/dba/in", "pos-external/dba/out", "pos-external/dubaibw/in", "pos-external/dubaibw/out", "pos-external/norfillmore/in", "pos-external/norfillmore/out", "pos-external/yardhouse/in", "pos-external/yardhouse/out", "pos-external/onprem/in", "pos-external/onprem/out", "ebank", "shelf/ethnicity/in", "shelf/ethnicity/out"]
bucket_name_mwaa                        = "czr-prod-usw2-daas-mwaa"
existing_bucket_name_inbound            = "czr-prod-usw2-daas-inbound"
inbound_objects                         = ["pdb/offer/history"]
mwaa_bucket_objects                     = ["dags"]
existing_bucket_name_outbound           = "czr-prod-usw2-daas-outbound"
lambda_arn_file_s3_to_sftp              = "czr-daas-lambda-usw2-prod-s3-to-sftp"
daas_processing_objects                 = ["Alerting"]
lifecycle_45_days                       = []
lifecycle_60_days                       = []
lifecycle_30_days                       = []
s3_logs_objects                         = ["czr-prod-usw2-daas-incoming-external"]
bucket_name_logs                        = "czr-prod-usw2-daas-s3-logs"
lifecycle_logs_day                      = ["czr-prod-usw2-daas-s3-logs"]
lifecycle_logs_days                     = "14"
existing_bucket_name_incoming_external_sox   = "czr-prod-usw2-daas-incoming-external-sox"
incoming_external_sox_objects                = ["FreedomPay", "Ticketmaster"]
