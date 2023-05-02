## Please do not touch this location 
s3_bucket       = "czr-platform-usw2-tf-state"
account         = "238837397276"
environment     = "prod"
s3_region       = "us-west-2"
s3_folder       = "share_tools"
s3_folder_type  = "sns"
s3_tfstate_file = "sns.tfstate"
## Please do not touch above code 

region          = "us-west-2"

sns_topic_name       = "czr-daas-prod-usw2-error-notify"
email_ids            = ["rohit.z.kumar@capgemini.com",
                        "vishal.chaure@capgemini.com",
                        "amit.dhumal@capgemini.com",
                        "samyukta.b@capgemini.com",
                        "daas_team-3@capgemini.com",
                        "hem.kishore@capgemini.com",
                        "jschwarz@caesars.com", 
                        "sgoss@caesars.com",
                        "plavigne@caesars.com",
                        "daasam.in@capgemini.com", 
                        "caesars@service-now.com",
                        "harshil.joshi@capgemini.com"]

