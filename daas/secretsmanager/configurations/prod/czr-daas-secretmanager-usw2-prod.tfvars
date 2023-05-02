## Please do not touch this location 
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "238837397276"
environment     = "prod"
s3_region       = "us-west-2"
s3_folder       = "share_tools"
s3_folder_type  = "secretsmanager"
s3_tfstate_file = "secretsmanager.tfstate"
## Please do not touch above code 
region          = "us-west-2"
secrets_timeworks_decryption_key        = "czr-daas-secret-prod-timeworks-decryption-key"
decryption_key_description              = "Decryption key provided by Wintel for decryption of Timeworks encrypted files"
secretkey_timeworks_decryption_key      = "TimeworksDecryptionASC"
secretvalue_timeworks_decryption_key    = "TBD"

secrets_timeworks_decryption_passphrase     = "czr-daas-secret-prod-timeworks-decryption-passphrase"
decryption_passphrase_description           = "Timeworks decryption key passphrase"
secretkey_timeworks_decryption_passphrase   = "passphrase"
secretvalue_timeworks_decryption_passphrase = "TBD"