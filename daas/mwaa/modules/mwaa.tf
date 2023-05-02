resource "aws_mwaa_environment" "mwaa_environment" {
  name                  = var.mwaa_environment_name
  execution_role_arn    = "arn:aws:iam::${var.account}:role/${var.execution_role}"
  source_bucket_arn     = "arn:aws:s3:::${var.source_s3_bucket}"
  dag_s3_path           = var.dag_s3_path
  plugins_s3_path       = var.plugins_s3_path
  requirements_s3_path  = var.requirements_s3_path
  webserver_access_mode = var.webserver_access_mode
  environment_class     = var.environment_class
  max_workers           = var.max_workers
  min_workers           = var.min_workers
  schedulers            = var.schedulers

  
  network_configuration {
    subnet_ids         = var.subnet_ids
    security_group_ids = var.security_group_ids
  }

  logging_configuration {
    dag_processing_logs {
      enabled   = true
      log_level = "WARNING"
    }

    scheduler_logs {
      enabled   = true
      log_level = "WARNING"
    }

    task_logs {
      enabled   = true
      log_level = "INFO"
    }

    webserver_logs {
      enabled   = true
      log_level = "WARNING"
    }

    worker_logs {
      enabled   = true
      log_level = "WARNING"
    }
  }

  airflow_configuration_options = {
    "celery.sync_parallelism"                   = 1
    "celery.worker_autoscale"                   = "10,10"
    "core.dag_concurrency"                      = 16
    "core.lazy_load_plugins"                    = "False"
    "core.parallelism"                          = 160
    "scheduler.after_task_execution"            = "False"
    "scheduler.min_file_process_interval"       = 60
    "scheduler.parsing_processes"               = 5
    "scheduler.scheduler_zombie_task_threshold" = 300
    "webserver.dag_default_view"                = "graph"    
  }
  
  tags = {
    Name        = var.mwaa_environment_name
    Environment = var.environment
    Application = var.application_code
    map-migrated= var.map-migrated-server-id
  }
}

output "mwaa_arn" {
  value = aws_mwaa_environment.mwaa_environment.arn
}

output "webserver_url" {
  value = aws_mwaa_environment.mwaa_environment.webserver_url
}
