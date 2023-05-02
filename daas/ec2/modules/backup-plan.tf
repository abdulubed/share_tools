resource "aws_backup_plan" "backup_plan" {
  name = var.backup_plan
  rule {
    rule_name         = var.daily_backup_rule
    target_vault_name = var.existing_backup_vault
    schedule          = var.daily_backup_schedule
    lifecycle {
      delete_after = var.delete_after_7_days 
    }
  }
  rule {
    rule_name         = var.weekly_backup_rule
    target_vault_name = var.existing_backup_vault
    schedule          = var.weekly_backup_schedule
    lifecycle {
      delete_after = var.delete_after_8_weeks 
    }
  }
  rule {
    rule_name         = var.monthly_backup_rule
    target_vault_name = var.existing_backup_vault
    schedule          = var.monthly_backup_schedule
    lifecycle {
      delete_after = var.delete_after_1_year 
    }
  }
  tags = {
    Name                   = "czr-daas-${var.region_code}-${var.environment}-backup-plan"
    Environment            = var.environment
    map-migrated           = var.map-migrated-server-id
  }
   advanced_backup_setting {
    backup_options = {
      WindowsVSS = "enabled"
    }
    resource_type = "EC2"
  }
}

data "aws_iam_role" "iam_role" {
  name = var.existing_iam_role
}

resource "aws_backup_selection" "backup_resource_selection" {
  iam_role_arn = data.aws_iam_role.iam_role.arn
  name         = var.backup_resource
  plan_id      = aws_backup_plan.backup_plan.id

  resources = [
     aws_instance.instance.arn
  ]
}
