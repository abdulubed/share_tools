provider "aws" {
  region          = var.region
  assume_role {
    role_arn      = "arn:aws:iam::${var.account}:role/Jenkins-Role"
  }
}

# create secrets manager for lambda mtd cvps database server1
resource "aws_secretsmanager_secret" "secrets_lambda_mtd_cvps_database_server1" {
  name = var.secrets_lambda_mtd_cvps_database_server1
  description = var.database_server1_description
  tags = {
      Name         = var.secrets_lambda_mtd_cvps_database_server1
      map-migrated = var.map-migrated-server-id  
  }
}

resource "aws_secretsmanager_secret_version" "secrets_lambda_mtd_cvps_database_server1" {
  secret_id     = "${aws_secretsmanager_secret.secrets_lambda_mtd_cvps_database_server1.id}"
  secret_string = <<EOF
  {
    "username"  : "${var.server1_username}",
    "password"  : "TBD",
    "engine"    : "${var.server1_engine}", 
    "host"      : "${var.server1_host}", 
    "port"      : "${var.server1_port}",
    "dbname"    : "${var.server1_dbname}"
  }
  EOF
}

# create secrets manager for lambda mtd cvps database server2
resource "aws_secretsmanager_secret" "secrets_lambda_mtd_cvps_database_server2" {
  name = var.secrets_lambda_mtd_cvps_database_server2
  description = var.database_server2_description
  tags = {
      Name         = var.secrets_lambda_mtd_cvps_database_server2
      map-migrated = var.map-migrated-server-id  
  }
}

resource "aws_secretsmanager_secret_version" "secrets_lambda_mtd_cvps_database_server2" {
  secret_id     = "${aws_secretsmanager_secret.secrets_lambda_mtd_cvps_database_server2.id}"
  secret_string = <<EOF
  {
    "username"  : "${var.server2_username}",
    "password"  : "TBD",
    "engine"    : "${var.server2_engine}", 
    "host"      : "${var.server2_host}", 
    "port"      : "${var.server2_port}",
    "dbname"    : "${var.server2_dbname}"
  }
  EOF
}

#create secret value for secrets manager for lambda mtd
resource "aws_secretsmanager_secret" "secrets_lambda_mtd_cvps_snowflake" {
  name = var.secrets_lambda_mtd_cvps_snowflake
  description = var.database_server2_description
  tags = {
      Name         = var.secrets_lambda_mtd_cvps_snowflake
      map-migrated = var.map-migrated-server-id  
  }
}
resource "aws_secretsmanager_secret_version" "secrets_lambda_mtd_cvps_snowflake" {
  secret_id     = "${aws_secretsmanager_secret.secrets_lambda_mtd_cvps_snowflake.id}"
  secret_string = <<EOF
  {
    "username"  : "${var.snowflake_username}",
    "password"  : "TBD",
    "engine"    : "${var.snowflake_engine}", 
    "host"      : "${var.snowflake_host}", 
    "port"      : "${var.snowflake_port}",
    "dbname"    : "${var.snowflake_dbname}",
    "schema"    : "${var.snowflake_schema}",
    "role"      : "${var.snowflake_role}",
    "warehouse" : "${var.snowflake_warehouse}",
    "account"   : "${var.snowflake_account}"
  }
  EOF
}