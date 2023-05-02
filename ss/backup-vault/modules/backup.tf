provider "aws" {
  region          = var.region
  assume_role {
    role_arn      = "arn:aws:iam::${var.account}:role/Jenkins-Role"
  }
}

resource "aws_backup_vault" "backup_vault" {
  name        = var.aws_backup_vault
  kms_key_arn = "arn:aws:kms:${var.region}:${var.account}:key/${var.kms_key}"
  tags = {
    Name                   = "czr-raas-${var.region_code}-${var.environment}-backup-vault"
    Environment            = var.environment
    map-migrated           = var.map-migrated-server-id
  }
}

resource "aws_backup_vault_policy" "vault_policy" {
  depends_on = [
    aws_backup_vault.backup_vault
  ]
  backup_vault_name = aws_backup_vault.backup_vault.name

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "default",
  "Statement": [
    {
      "Sid": "default",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "backup:DeleteBackupVault",
        "backup:DeleteBackupVaultAccessPolicy",
        "backup:DeleteRecoveryPoint",
        "backup:StartCopyJob",
        "backup:StartRestoreJob",
        "backup:UpdateRecoveryPointLifecycle",
        "backup:DescribeBackupVault",
        "backup:PutBackupVaultAccessPolicy",
        "backup:GetBackupVaultAccessPolicy",
        "backup:StartBackupJob",
        "backup:GetBackupVaultNotifications",
        "backup:PutBackupVaultNotifications"
      ],
      "Resource": [
       "${aws_backup_vault.backup_vault.arn}",
       "*"
       ]
    }
  ]
}
POLICY
}

resource "aws_iam_role" "iam_role" {
  name               = var.aws_iam_role
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": ["sts:AssumeRole"],
      "Effect": "allow",
      "Principal": {
        "Service": ["backup.amazonaws.com"]
      }
    }
  ]
}
POLICY

tags = {
    Name                   = "czr-raas-${var.region_code}-${var.environment}-backup-role"
    Environment            = var.environment
    map-migrated           = var.map-migrated-server-id
  }
}


resource "aws_iam_role_policy_attachment" "role_policy_attachment" {
   depends_on = [
    aws_iam_role.iam_role
  ]
  role        = aws_iam_role.iam_role.name
  count      = "${length(var.iam_policy_arn)}"
  policy_arn = "${var.iam_policy_arn[count.index]}"
}

