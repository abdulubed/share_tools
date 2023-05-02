resource "aws_cloudwatch_log_group" "log_group" {
  name = "msk_broker_logs"
  retention_in_days = var.retention_in_days
  tags = {
      Name                   = "czr-raas-cloudwatch-${var.region_code}-${var.environment}-${var.application}"
      map-migrated           = var.map-migrated-server-id
    } 
}