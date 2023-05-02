resource "aws_kms_key" "kms_key" {
  key_usage  = "ENCRYPT_DECRYPT"
  customer_master_key_spec =  "SYMMETRIC_DEFAULT"
  policy = <<EOF
{
      "Version": "2012-10-17",
    "Id": "key-default-1",
    "Statement": [
        {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${var.account}:root"
            },
            "Action": "kms:*",
            "Resource": "*"
        }
    ]
}
 EOF 
}

resource "aws_kms_alias" "kms_alias" {
  name          = "alias/czr-raas-kms-${var.region_code}-${var.environment}-${var.application}"
  target_key_id = aws_kms_key.kms_key.key_id
}


