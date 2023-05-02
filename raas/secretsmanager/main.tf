provider "aws" {
  region          = var.region
  assume_role {
    role_arn      = "arn:aws:iam::${var.account}:role/Jenkins-Role"
  }
}

# create secrets manager for raas database
resource "aws_secretsmanager_secret" "secrets_raas_database" {
  name = var.secrets_raas_database
  description = var.database_description 
  tags = {
      Name         = var.secrets_raas_database
      map-migrated = var.map-migrated-server-id  
  }
}
resource "aws_secretsmanager_secret_version" "secrets_raas_database" {
  secret_id     = "${aws_secretsmanager_secret.secrets_raas_database.id}"
  secret_string = <<EOF
  {
    "DB_USERNAME": "${var.database_username}",
    "DB_PASSWORD": "TBD",
    "DB_HOST": "${var.database_host}", 
    "DB_DATABASE": "${var.db_database}",
    "DB_PORT": "${var.database_port}"
  }
  EOF
}

# create secrets manager for raas database
resource "aws_secretsmanager_secret" "secrets_raas_offers_database" {
  name = var.secrets_raas_offers_database
  description = var.secrets_raas_offers_database_description 
  tags = {
      Name         = var.secrets_raas_offers_database
      map-migrated = var.map-migrated-server-id  
  }
}
resource "aws_secretsmanager_secret_version" "secrets_raas_offers_database" {
  secret_id     = "${aws_secretsmanager_secret.secrets_raas_offers_database.id}"
  secret_string = <<EOF
  {
    "DB_HOST": "${var.database_host}", 
    "DB_DATABASE": "${var.db_raas_offers_database_name}",
    "DB_USERNAME": "${var.db_raas_offers_database_userid}",
    "DB_PASSWORD": "TBD",
    "DB_PORT": "${var.database_port}"
  }
  EOF
}

#create secret value for raas jwt
resource "aws_secretsmanager_secret" "secrets_raas_jwt" {
  name = var.secrets_raas_jwt 
  description = var.jwt_description
  tags = {
      Name         = var.secrets_raas_jwt 
      map-migrated = var.map-migrated-server-id  
  }
}

resource "aws_secretsmanager_secret_version" "secrets_raas_jwt" {
  secret_id     = "${aws_secretsmanager_secret.secrets_raas_jwt.id}"
  secret_string = <<EOF
  {
    "internal": "${var.jwt_internal}",
    "auth": "${var.jwt_auth}", 
    "mfa": "${var.jwt_mfa}"
  }
  EOF
}


# create secrets manager for raas strikeiron
resource "aws_secretsmanager_secret" "secrets_raas_strikeiron" {
  name = var.secrets_raas_strikeiron
  description = var.strikeiron_description
  tags = {
      Name         = var.secrets_raas_strikeiron
      map-migrated = var.map-migrated-server-id  
  }
}

resource "aws_secretsmanager_secret_version" "secrets_raas_strikeiron" {
  secret_id     = "${aws_secretsmanager_secret.secrets_raas_strikeiron.id}"
  secret_string = <<EOF
  {
    "username": "${var.strikeiron_username}",
    "password": "TBD",
    "url": "${var.strikeiron_url}"
  }
  EOF
}

# create secrets manager for raas eml
resource "aws_secretsmanager_secret" "secrets_raas_eml" {
  name = var.secrets_raas_eml
  description = var.eml_description
  tags = {
      Name         = var.secrets_raas_eml
      map-migrated = var.map-migrated-server-id  
  }
}

resource "aws_secretsmanager_secret_version" "secrets_raas_eml" {
  secret_id     = "${aws_secretsmanager_secret.secrets_raas_eml.id}"
  secret_string = <<EOF
  {
    "api_key": "${var.em1_api_key}",
    "secret": "${var.em1_secret}", 
    "url": "${var.em1_url}"
  }
  EOF
}

# create secrets manager for raas gms
resource "aws_secretsmanager_secret" "secrets_raas_gms" {
  name = var.secrets_raas_gms
  description = var.gms_description
  tags = {
      Name         = var.secrets_raas_gms
      map-migrated = var.map-migrated-server-id  
  }
}

resource "aws_secretsmanager_secret_version" "secrets_raas_gms" {
  secret_id     = "${aws_secretsmanager_secret.secrets_raas_gms.id}"
  secret_string = <<EOF
  {
    "api_key": "${var.gms_api_key}",
    "secret": "${var.gms_secret}", 
    "createGuestAccountUrl": "${var.gms_url}",
    "getGuestProfileWithOptionsUrl": "${var.gms_optionsUrl}",
    "authenticateUserWithProfileUrl": "${var.gms_profileUrl}",
    "getGuestProfileCompleteInfoUrl": "${var.gms_completeInfoUrl}",
    "createPasswordUrl": "${var.gms_createPasswordUrl}",
    "updatePasswordUrl": "${var.gms_updatePasswordUrl}",
    "updateGuestProfileUrl": "${var.gms_updateGuestProfileUrl}",
    "getPreferences": "${var.gms_getPreferences}",
    "updatePreferences": "${var.gms_updatePreferences}"
  }
  EOF
}

# create secrets manager for raas gms guest
resource "aws_secretsmanager_secret" "secrets_raas_gms_guest" {
  name = var.secrets_raas_gms_guest
  description = var.gms_guest_description
  tags = {
      Name         = var.secrets_raas_gms
      map-migrated = var.map-migrated-server-id  
  }
}

resource "aws_secretsmanager_secret_version" "secrets_raas_gms_guest" {
  secret_id     = "${aws_secretsmanager_secret.secrets_raas_gms_guest.id}"
  secret_string = <<EOF
  {
    "api_key": "${var.gms_guest_api_key}",
    "secret": "${var.gms_guest_secret}", 
    "url": "${var.gms_guest_url}"
  }
  EOF
}

# create secrets manager for raas pdb_republish 
resource "aws_secretsmanager_secret" "secrets_raas_pdb_republish" {
  name = var.secrets_raas_pdb_republish
  description = var.pdb_republish_description
  tags = {
      Name         = var.secrets_raas_pdb_republish 
      map-migrated = var.map-migrated-server-id  
  }
}

resource "aws_secretsmanager_secret_version" "secrets_raas_pdb_republish" {
  secret_id     = "${aws_secretsmanager_secret.secrets_raas_pdb_republish.id}"
  secret_string = <<EOF
  {
    "api_key": "${var.pdb_republish_api_key}",
    "secret": "${var.pdb_republish_secret}", 
    "url": "${var.pdb_republish_url}"
  }
  EOF
}

# create secrets manager for raas kafka
resource "aws_secretsmanager_secret" "secrets_raas_kafka" {
  name = var.secrets_raas_kafka 
  description = var.kafka_description
  tags = {
      Name         = var.secrets_raas_kafka 
      map-migrated = var.map-migrated-server-id  
  }
}

resource "aws_secretsmanager_secret_version" "secrets_raas_kafka" {
  secret_id     = "${aws_secretsmanager_secret.secrets_raas_kafka .id}"
  secret_string = <<EOF
  {
    "url": "${var.kafka_url}"
  }
  EOF
}

# create secrets manager for raas security questions limit
resource "aws_secretsmanager_secret" "secrets_raas_security_questions_limit" {
  name = var.secrets_raas_security_questions_limit 
  description = var.security_questions_limit_description
  tags = {
      Name         = var.secrets_raas_security_questions_limit 
      map-migrated = var.map-migrated-server-id  
  }
}

resource "aws_secretsmanager_secret_version" "secrets_raas_security_questions_limit" {
  secret_id     = "${aws_secretsmanager_secret.secrets_raas_security_questions_limit .id}"
  secret_string = <<EOF
  {
    "min": "${var.min}"
  }
  EOF
}

# create secrets manager for raas aws lambda enc secret
resource "aws_secretsmanager_secret" "secrets_raas_aws_lambda_enc_secret" {
  name = var.secrets_raas_aws_lambda_enc_secret 
  description = var.aws_lambda_enc_secret_description
  tags = {
      Name         = var.secrets_raas_aws_lambda_enc_secret 
      map-migrated = var.map-migrated-server-id  
  }
}

resource "aws_secretsmanager_secret_version" "secrets_raas_aws_lambda_enc_secret" {
  secret_id     = "${aws_secretsmanager_secret.secrets_raas_aws_lambda_enc_secret.id}"
  secret_string = <<EOF
  {
    "CRYPTO_SECRET": "${var.crypto_secret}",
    "STANDARD_STRING": "${var.standard_string}"
    
  }
  EOF
}

# create secrets manager for raas sms service config
resource "aws_secretsmanager_secret" "secrets_raas_sms_service_config" {
  name = var.secrets_raas_sms_service_config  
  description = var.sms_service_config_description
  tags = {
      Name         = var.secrets_raas_sms_service_config  
      map-migrated = var.map-migrated-server-id  
  }
}

resource "aws_secretsmanager_secret_version" "secrets_raas_sms_service_config" {
  secret_id     = "${aws_secretsmanager_secret.secrets_raas_sms_service_config.id}"
  secret_string = <<EOF
  {
    "auth_token_url": "${var.sms_auth_token_url}",
    "auth_grant_type": "${var.sms_auth_grant_type}", 
    "auth_client_secret": "${var.sms_auth_client_secret}",
    "auth_client_id": "${var.sms_auth_client_id}",
    "auth_account_id": "${var.sms_auth_account_id}",
    "sms_url": "${var.sms_url}"
  }
  EOF
}

# create secrets manager for raas gms get rg info secret
resource "aws_secretsmanager_secret" "secrets_raas_gms_get_rg_info" {
  name = var.secrets_raas_gms_get_rg_info  
  description = var.gms_get_rg_info_description 
  tags = {
      Name         = var.secrets_raas_gms_get_rg_info  
      map-migrated = var.map-migrated-server-id  
  }
}

resource "aws_secretsmanager_secret_version" "secrets_raas_gms_get_rg_info" {
  secret_id     = "${aws_secretsmanager_secret.secrets_raas_gms_get_rg_info.id}"
  secret_string = <<EOF
  {
    "url": "${var.gms_get_rg_url}",
    "api_key": "${var.gms_get_rg_api_key}", 
    "secret": "${var.gms_get_rg_secret}"
  }
  EOF
}


# create secrets manager for raas gms get rg info secret
resource "aws_secretsmanager_secret" "secrets_raas_error_logger" {
  name = var.secrets_raas_error_logger  
  description = var.error_logger_description 
  tags = {
      Name         = var.secrets_raas_error_logger  
      map-migrated = var.map-migrated-server-id  
  }
}

resource "aws_secretsmanager_secret_version" "secrets_raas_error_logger" {
  secret_id     = "${aws_secretsmanager_secret.secrets_raas_error_logger.id}"
  secret_string = <<EOF
  {
    "url": "${var.error_logger_url}"
  }
  EOF
}

# create secrets manager for raas gms validate oauthtoken
resource "aws_secretsmanager_secret" "secrets_raas_gms_validate_oauthtoken" {
  name = var.secrets_raas_gms_validate_oauthtoken 
  description = var.gms_validate_oauthtoken_description 
  tags = {
      Name         = var.secrets_raas_gms_validate_oauthtoken  
      map-migrated = var.map-migrated-server-id
      }  
}

resource "aws_secretsmanager_secret_version" "secrets_raas_gms_validate_oauthtoken" {
  secret_id     = "${aws_secretsmanager_secret.secrets_raas_gms_validate_oauthtoken.id}"
  secret_string = <<EOF
  {
    "api_key": "TBD",
    "secret": "TBD",
    "url": "${var.gms_validate_oauthtoken_url}"
  }
  EOF
}

# create secrets manager for raas gms validate oauthtoken
resource "aws_secretsmanager_secret" "secrets_raas_leap_auth_provider" {
  name = var.secrets_raas_leap_auth_provider 
  description = var.leap_auth_provider_description 
  tags = {
      Name         = var.secrets_raas_leap_auth_provider 
      map-migrated = var.map-migrated-server-id
      }  
}

resource "aws_secretsmanager_secret_version" "secrets_raas_leap_auth_provider" {
  secret_id     = "${aws_secretsmanager_secret.secrets_raas_leap_auth_provider.id}"
  secret_string = <<EOF
  {
    "api_key": "TBD",
    "secret": "TBD",
    "application_key": "TBD",
    "application_id": "TBD",
    "url": "${var.leap_auth_provider_url}"
  }
  EOF
}

# create secrets manager for raas sa get rg info secret
resource "aws_secretsmanager_secret" "secrets_raas_sa_get_rg_info" {
  name = var.secrets_raas_sa_get_rg_info  
  description = var.sa_get_rg_info_description 
  tags = {
      Name         = var.secrets_raas_sa_get_rg_info  
      map-migrated = var.map-migrated-server-id  
  }
}

resource "aws_secretsmanager_secret_version" "secrets_raas_sa_get_rg_info" {
  secret_id     = "${aws_secretsmanager_secret.secrets_raas_sa_get_rg_info.id}"
  secret_string = <<EOF
  {
    "url": "${var.sa_get_rg_url}",
    "api_key": "${var.sa_get_rg_api_key}", 
    "secret": "${var.sa_get_rg_secret}"
  }
  EOF
}
