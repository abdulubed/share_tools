provider "aws" {
  region          = var.region
  assume_role {
    role_arn      = "arn:aws:iam::${var.account}:role/Jenkins-Role"
  }
}

# create secrets manager for Timeworks decryption key
resource "aws_secretsmanager_secret" "secrets_timeworks_decryption_key" {
  name = var.secrets_timeworks_decryption_key
  description = var.decryption_key_description
  tags = {
      Name         = var.secrets_timeworks_decryption_key
      map-migrated = var.map-migrated-server-id  
  }
}

# create secret value for secrets manager timeworks decryption key
resource "aws_secretsmanager_secret_version" "secrets_timeworks_decryption_key_secretvalue" {
  secret_id     = "${aws_secretsmanager_secret.secrets_timeworks_decryption_key.id}"
  secret_string = jsonencode({ "${var.secretkey_timeworks_decryption_key}" = var.secretvalue_timeworks_decryption_key})
}

# create secrets manager for Timeworks decryption passphrase
resource "aws_secretsmanager_secret" "secrets_timeworks_decryption_passphrase" {
  name = var.secrets_timeworks_decryption_passphrase
  description = var.decryption_passphrase_description
  tags = {
      Name         = var.secrets_timeworks_decryption_passphrase
      map-migrated = var.map-migrated-server-id
  }
}

# create secret value for secrets manager timeworks decryption passphrase
resource "aws_secretsmanager_secret_version" "secrets_timeworks_decryption_passphrase_secretvalue" {
  secret_id     = "${aws_secretsmanager_secret.secrets_timeworks_decryption_passphrase.id}"
#  secret_string = jsonencode({"AccessKey" = var.acceskeypassphrase, "SecretAccessKey" = var.secretkeypassphrase})
  secret_string = jsonencode({ "${var.secretkey_timeworks_decryption_passphrase}" = var.secretvalue_timeworks_decryption_passphrase })
}
