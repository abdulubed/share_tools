# create secrets manager for raas msk
resource "aws_secretsmanager_secret" "secrets_msk_secret" {
  name = var.secrets_msk_name
  description = var.msk_secret_description 
  tags = {
      Name         = var.secrets_msk_name
      map-migrated = var.map-migrated-server-id  
  }
  kms_key_id = aws_kms_key.kms_key.arn
}
resource "aws_secretsmanager_secret_version" "secrets_msk_version" {
  secret_id     = aws_secretsmanager_secret.secrets_msk_secret.id
  secret_string = <<EOF
  {
    "username": "${var.msk_username}",
    "password": "TBD"
  }
  EOF

  depends_on = [
    aws_secretsmanager_secret.secrets_msk_secret
  ]
}

resource "aws_secretsmanager_secret_rotation" "secret_rotation" {
  secret_id           = aws_secretsmanager_secret.secrets_msk_secret.id
  rotation_lambda_arn = aws_lambda_function.lambda.arn

  rotation_rules {
    automatically_after_days = 1
  }

    depends_on = [
    aws_lambda_function.lambda
  ]
}