resource "aws_s3_bucket" "buckets" {
  count = "${length(var.bucket_list)}"
  bucket = "${element(var.bucket_list, count.index)}"
    tags = {
    Name = "${element(var.bucket_list, count.index)}"
    Environment = var.environment
    map-migrated= var.map-migrated-server-id
  }
}

resource "aws_s3_bucket_acl" "buckets" {
  count = "${length(var.bucket_list)}"
  bucket = var.bucket_list[count.index]
  acl    = var.s3_acl
}

resource "aws_s3_bucket_versioning" "versioning" {
  count = "${length(var.bucket_list)}"
  bucket = var.bucket_list[count.index]
  versioning_configuration {
    status = var.s3_version_enabled
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption"{
  count = "${length(var.bucket_list)}"
  bucket = var.bucket_list[count.index]
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = var.s3_sse_default
      }
    }
}

resource "aws_s3_bucket_policy" "SecureTransport" {
  count = "${length(var.bucket_list)}"
  bucket = "${element(var.bucket_list, count.index)}"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "EnforceMinimumTLS",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::${var.bucket_list[count.index]}/*",
            "Condition": {
                "Bool": {
                    "aws:SecureTransport": "false"
                },
                "NumericLessThan": {
                    "s3:TlsVersion": "1.2"
                }
            }
        }
    ]
  })
}

resource "aws_s3_object" "folders_incoming_external" {
    count  = "${length(var.incoming_external_objects)}"
    bucket = var.existing_bucket_name_incoming_external
    acl    = "private"
    key    = "${var.incoming_external_objects[count.index]}/"
}

resource "aws_s3_object" "inbound_objects" {
    count  = "${length(var.inbound_objects)}"
    bucket = var.existing_bucket_name_inbound
    acl    = "private"
    key    = "${var.inbound_objects[count.index]}/"
}

resource "aws_s3_object" "folders_mwaa" {
  count   = "${length(var.mwaa_bucket_objects)}"
  bucket  = var.bucket_name_mwaa
  acl     = "private"
  key     = "${var.mwaa_bucket_objects[count.index]}/"
}

resource "aws_s3_object" "folders_daas_processing" {
    count  = "${length(var.daas_processing_objects)}"
    bucket = var.bucket_name_daas_processing
    acl    = "private"
    key    = "${var.daas_processing_objects[count.index]}/"
}

resource "aws_s3_object" "folders_incoming_external_sox" {
    count  = "${length(var.incoming_external_sox_objects)}"
    bucket = var.existing_bucket_name_incoming_external_sox
    acl    = "private"
    key    = "${var.incoming_external_sox_objects[count.index]}/"
}

## Get exising bucket was created
data "aws_s3_bucket" "bucket" {
  bucket = var.existing_bucket_name_incoming_external
}

## Setting up the event notifications for lambda and queue 
resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = data.aws_s3_bucket.bucket.id

  lambda_function {
    id                  = "s3-lambda-event-pos-hosted"
    lambda_function_arn = "arn:aws:lambda:${var.region}:${var.account}:function:${var.lambda_arn_hosted_preprocess}"
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "pos/"
  }

  lambda_function {
    id                  = "s3-lambda-event-timeworks-file-decrypt"
    lambda_function_arn = "arn:aws:lambda:${var.region}:${var.account}:function:${var.lambda_arn_file_decrypt}"
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "timeworks/encrypted"
    filter_suffix      = ".pgp"
  }

  lambda_function {
    id                  = "s3-lambda-event-file-rename-timeworks"
    lambda_function_arn = "arn:aws:lambda:${var.region}:${var.account}:function:${var.lambda_arn_file_rename}"
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "timeworks/in/"
  }

  lambda_function {
    id            = "s3-lambda-event-file-rename-pos-external-agilysys"
    lambda_function_arn = "arn:aws:lambda:${var.region}:${var.account}:function:${var.lambda_arn_file_rename}"
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "pos-external/agilysys/in/"
  }

  lambda_function {
    id            = "s3-lambda-event-file-rename-pos-external-chayolinq"
    lambda_function_arn = "arn:aws:lambda:${var.region}:${var.account}:function:${var.lambda_arn_file_rename}"
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "pos-external/chayolinq/in/"
  }

  lambda_function {
    id            = "s3-lambda-event-file-rename-pos-external-d365"
    lambda_function_arn = "arn:aws:lambda:${var.region}:${var.account}:function:${var.lambda_arn_file_rename}"
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "pos-external/d365/in/"
  }

  lambda_function {
    id            = "s3-lambda-event-file-rename-pos-external-dba"
    lambda_function_arn = "arn:aws:lambda:${var.region}:${var.account}:function:${var.lambda_arn_file_rename}"
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "pos-external/dba/in/"
  }

  lambda_function {
    id            = "s3-lambda-event-file-rename-pos-external-dubaibw"
    lambda_function_arn = "arn:aws:lambda:${var.region}:${var.account}:function:${var.lambda_arn_file_rename}"
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "pos-external/dubaibw/in/"
  }

  lambda_function  {
    id            = "s3-lambda-event-file-rename-pos-external-norfillmore"
    lambda_function_arn = "arn:aws:lambda:${var.region}:${var.account}:function:${var.lambda_arn_file_rename}"
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "pos-external/norfillmore/in/"
  }

  lambda_function  {
    id            = "s3-lambda-event-file-rename-pos-external-yardhouse"
    lambda_function_arn = "arn:aws:lambda:${var.region}:${var.account}:function:${var.lambda_arn_file_rename}"
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "pos-external/yardhouse/in/"
  }

  lambda_function  {
    id            = "s3-lambda-event-file-rename-pos-external-onprem"
    lambda_function_arn = "arn:aws:lambda:${var.region}:${var.account}:function:${var.lambda_arn_file_rename}"
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "pos-external/onprem/in/"
 }

 lambda_function  {
    id            = "s3-lambda-event-igaming-pos-external"
    lambda_function_arn = "arn:aws:lambda:${var.region}:${var.account}:function:${var.lambda_arn_igaming}"
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "iGaming/in/"
 }

 lambda_function  {
    id            = "s3-lambda-event-shelf-ethnicity"
    lambda_function_arn = "arn:aws:lambda:${var.region}:${var.account}:function:${var.lambda_arn_ethnicity}"
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "shelf/ethnicity/in"
 }
 

  queue {
    id            = "s3-snowpipe-event-pos-hosted"
    queue_arn     = "arn:aws:sqs:${var.region}:${var.sqs_account}:${var.existing_sqs_queue_arn_snowpipe}"
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "pos-processing-trigger/"
  }

  queue {
    id            = "s3-snowpipe-event-timeworks"
    queue_arn     = "arn:aws:sqs:${var.region}:${var.sqs_account}:${var.existing_sqs_queue_arn_snowpipe}"
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "timeworks/out/"
  }

  queue {
    id            = "s3-snowpipe-event-ebank"
    queue_arn     = "arn:aws:sqs:${var.region}:${var.sqs_account}:${var.existing_sqs_queue_arn_snowpipe}"
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "ebank/"
  }

  queue {
    id            = "s3-snowpipe-event-pos-external-agilysys"
    queue_arn     = "arn:aws:sqs:${var.region}:${var.sqs_account}:${var.existing_sqs_queue_arn_snowpipe}"
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "pos-external/agilysys/out/"
  }

  queue {
    id            = "s3-snowpipe-event-pos-external-chayolinq"
    queue_arn     = "arn:aws:sqs:${var.region}:${var.sqs_account}:${var.existing_sqs_queue_arn_snowpipe}"
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "pos-external/chayolinq/out/"
  }

  queue {
    id            = "s3-snowpipe-event-pos-external-d365"
    queue_arn     = "arn:aws:sqs:${var.region}:${var.sqs_account}:${var.existing_sqs_queue_arn_snowpipe}"
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "pos-external/d365/out/"
  }

  queue {
    id            = "s3-snowpipe-event-pos-external-dba"
    queue_arn     = "arn:aws:sqs:${var.region}:${var.sqs_account}:${var.existing_sqs_queue_arn_snowpipe}"
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "pos-external/dba/out/"
  }

  queue {
    id            = "s3-snowpipe-event-pos-external-dubaibw"
    queue_arn     = "arn:aws:sqs:${var.region}:${var.sqs_account}:${var.existing_sqs_queue_arn_snowpipe}"
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "pos-external/dubaibw/out/"
  }

  queue {
    id            = "s3-snowpipe-event-pos-external-norfillmore"
    queue_arn     = "arn:aws:sqs:${var.region}:${var.sqs_account}:${var.existing_sqs_queue_arn_snowpipe}"
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "pos-external/norfillmore/out/"
  }

  queue {
    id            = "s3-snowpipe-event-pos-external-yardhouse"
    queue_arn     = "arn:aws:sqs:${var.region}:${var.sqs_account}:${var.existing_sqs_queue_arn_snowpipe}"
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "pos-external/yardhouse/out/"
  }

  queue {
    id            = "s3-snowpipe-event-pos-external-onprem"
    queue_arn     = "arn:aws:sqs:${var.region}:${var.sqs_account}:${var.existing_sqs_queue_arn_snowpipe}"
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "pos-external/onprem/out/"
  }
 
  queue {
    id            = "s3-snowpipe-event-iGaming"
    queue_arn     = "arn:aws:sqs:${var.region}:${var.sqs_account}:${var.existing_sqs_queue_arn_snowpipe}"
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "iGaming/out/"
  }  

  queue {
    id            = "s3-snowpipe-event-snowshelf-ethnicity"
    queue_arn     = "arn:aws:sqs:${var.region}:${var.sqs_account}:${var.existing_sqs_queue_arn_snowpipe}"
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "shelf/ethnicity/out"
  }   

}

## Get exising bucket was created 
data "aws_s3_bucket" "bucket1" {
  bucket = var.existing_bucket_name_outbound
}

## Setting up the event notifications for lambda in bucket oubound
resource "aws_s3_bucket_notification" "bucket_notification1" {
  bucket = data.aws_s3_bucket.bucket1.id

    lambda_function  {
    id            = "s3-lambda-event-s3-to-sftp"
    lambda_function_arn = "arn:aws:lambda:${var.region}:${var.account}:function:${var.lambda_arn_file_s3_to_sftp}"
    events        = ["s3:ObjectCreated:*"]
 }
}


resource "aws_s3_bucket_public_access_block" "mwaa_bucket_public_access_block" {
  bucket                  = var.bucket_name_mwaa
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket" "bucket1" {
  bucket = var.bucket_name_daas_processing
    tags = {
    Name = var.bucket_name_daas_processing
    Environment = var.environment
    map-migrated= var.map-migrated-server-id
  }
}

resource "aws_s3_bucket_acl" "bucket1" {
  bucket = var.bucket_name_daas_processing
  acl    = var.s3_acl
}

resource "aws_s3_bucket_versioning" "versioning1" {
  bucket = var.bucket_name_daas_processing
  versioning_configuration {
    status = var.s3_version_enabled
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption1"{
  bucket = var.bucket_name_daas_processing
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = var.s3_sse_default
      }
    }
}

resource "aws_s3_bucket_policy" "SecureTransport1" {
  bucket = aws_s3_bucket.bucket1.id
  policy = jsonencode({
    
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "EnforceMinimumTLS",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::czr-${var.environment}-usw2-daas-processing/*",
            "Condition": {
                "Bool": {
                    "aws:SecureTransport": "false"
                },
                "NumericLessThan": {
                    "s3:TlsVersion": "1.2"
                }
            }
        },
        {
            "Sid": "AllowAppFlowDestinationActions",
            "Effect": "Allow",
            "Principal": {
                "Service": "appflow.amazonaws.com"
            },
            "Action": [
                "s3:PutObject",
                "s3:AbortMultipartUpload",
                "s3:ListMultipartUploadParts",
                "s3:ListBucketMultipartUploads",
                "s3:GetBucketAcl",
                "s3:PutObjectAcl"
            ],
            "Resource": [ 
                "arn:aws:s3:::czr-${var.environment}-usw2-daas-processing",
                "arn:aws:s3:::czr-${var.environment}-usw2-daas-processing/*"
            ],
            "Condition": {
                "StringEquals": {
                    "aws:SourceAccount": "${var.account}"
                }
            }
        }
    ]
  }) 
} 

# Lifecycle configuration for 45 days
resource "aws_s3_bucket_lifecycle_configuration" "lifecycle_configuration" {
  count = "${length(var.lifecycle_45_days)}"
  bucket = "${element(var.lifecycle_45_days, count.index)}"

  rule {
    id = "delete_object_45days"

    noncurrent_version_expiration {
      noncurrent_days = 45
    }

    expiration {
      days = 45
    }

   filter {}
   status = "Disabled"
  }

  rule {
    id = "delete_marker_45days"

     filter {}

     abort_incomplete_multipart_upload {
       days_after_initiation = 45
     }
     expiration{
       expired_object_delete_marker = true
       //days = 45
     }
    status = "Disabled"
  } 
}

# Lifecycle configuration for 60 days
resource "aws_s3_bucket_lifecycle_configuration" "lifecycle_60_configuration" {
  count = "${length(var.lifecycle_60_days)}"
  bucket = "${element(var.lifecycle_60_days, count.index)}"

  rule {
    id = "delete_object_60days"
    noncurrent_version_expiration {
      noncurrent_days = 60
    }

    expiration {
      days = 60
    }

   filter {
   }
   status = "Enabled"
  }

  rule {
    id = "delete_marker_60days"

     filter {
     }

     abort_incomplete_multipart_upload {
       days_after_initiation = 60
     }
     expiration{
       expired_object_delete_marker = true
     }
    status = "Enabled"
  } 
  rule {
    id = "igaming_object_1day"
    noncurrent_version_expiration {
      noncurrent_days = 1
    }

    expiration {
      days = 1
    }

    filter {
      prefix = "iGaming/in/"
    }
   status = "Enabled"
  }
}

#Lifecycle configuration for 30 days
resource "aws_s3_bucket_lifecycle_configuration" "lifecycle_30_days" {
  count = "${length(var.lifecycle_30_days)}"
  bucket = "${element(var.lifecycle_30_days, count.index)}"

  rule {
    id = "delete_object_30days"

    noncurrent_version_expiration {
      noncurrent_days = 30
    }

    expiration {
      days = 30
    }

   filter {}
   status = "Enabled"
  }

  rule {
    id = "delete_marker_30days"

     filter {}

     abort_incomplete_multipart_upload {
       days_after_initiation = 30
     }
     expiration{
       expired_object_delete_marker = true
     }
    status = "Enabled"
  } 
}

# S3 bucket for logs
resource "aws_s3_bucket" "s3_bucket_logs" {
  bucket = var.bucket_name_logs
    tags = {
    Name = var.bucket_name_logs
    Environment = var.environment
    map-migrated= var.map-migrated-server-id
  }
}

resource "aws_s3_bucket_acl" "s3_bucket_logs" {
  bucket = var.bucket_name_logs
  acl    = var.s3_acl
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption2"{
  bucket = var.bucket_name_logs
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = var.s3_sse_default
      }
    }
}

resource "aws_s3_bucket_policy" "SecureTransport2" {
  bucket = aws_s3_bucket.s3_bucket_logs.id
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "S3ServerAccessLogsPolicy",
            "Effect": "Allow",
            "Principal": {
                "Service": "logging.s3.amazonaws.com"
            },
            "Action": [
                "s3:PutObject"
            ],
            "Resource": "arn:aws:s3:::czr-${var.environment}-usw2-daas-s3-logs/czr-${var.environment}-usw2-daas-incoming-external*",
            "Condition": {
                "ArnLike": {
                    "aws:SourceArn": "arn:aws:s3:::czr-${var.environment}-usw2-daas-incoming-external"
                },
                "StringEquals": {
                    "aws:SourceAccount": "${var.account}"
                }
            }
        },
		{
            "Sid": "EnforceMinimumTLS",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::czr-${var.environment}-usw2-daas-s3-logs/*",
            "Condition": {
                "Bool": {
                    "aws:SecureTransport": "false"
                },
                "NumericLessThan": {
                    "s3:TlsVersion": "1.2"
                }
            }
        }
    ]
	
}) 
} 

# Folder creation inside logs bucket
resource "aws_s3_object" "folders_s3_logs" {
    count  = "${length(var.s3_logs_objects)}"
    bucket = var.bucket_name_logs
    acl    = "private"
    key    = "${var.s3_logs_objects[count.index]}/"
}

resource "aws_s3_bucket_logging" "s3_logging" {
  bucket = var.existing_bucket_name_incoming_external
  target_bucket = aws_s3_bucket.s3_bucket_logs.id
  target_prefix = "${var.existing_bucket_name_incoming_external}/"
}

#Lifecycle for S3_logs bucket
resource "aws_s3_bucket_lifecycle_configuration" "lifecycle_logs_day" {
  count = "${length(var.lifecycle_logs_day)}"
  bucket = "${element(var.lifecycle_logs_day, count.index)}"

  rule {
    id = "delete_object_${var.lifecycle_logs_days}days"

    noncurrent_version_expiration {
      noncurrent_days = "${var.lifecycle_logs_days}"
    }

    expiration {
      days = "${var.lifecycle_logs_days}"
    }

   filter {
      prefix = "czr-${var.environment}-usw2-daas-incoming-external/"
    }
   status = "Enabled"
  }

  rule {
    id = "delete_marker_${var.lifecycle_logs_days}days"

     filter {
      prefix = "czr-${var.environment}-usw2-daas-incoming-external/"
    }

     abort_incomplete_multipart_upload {
       days_after_initiation = 1
     }
     expiration{
       expired_object_delete_marker = true
     }
    status = "Enabled"
  } 
}
