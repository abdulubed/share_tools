resource "aws_msk_cluster" "msk_cluster" {
  cluster_name           = var.cluster_name
  kafka_version          =  var.kafka_version
  number_of_broker_nodes = var.number_of_broker_nodes
  enhanced_monitoring    = var.enhanced_monitoring
  
  client_authentication {
    sasl {
      iam = true
      scram = true
    }
  }

  broker_node_group_info {
    instance_type = var.instance_type
    client_subnets = var.client_subnets
    ebs_volume_size = var.volume_size
    security_groups = [aws_security_group.msk_security_group.id]
  }

  encryption_info {
    encryption_at_rest_kms_key_arn = aws_kms_key.kms_key.arn
  }

  logging_info {
    broker_logs {
      cloudwatch_logs {
        enabled   = true
        log_group = aws_cloudwatch_log_group.log_group.name
      }
    }
  }

  configuration_info {
    arn = aws_msk_configuration.msk_configuration.arn
    revision = aws_msk_configuration.msk_configuration.latest_revision
  }

  tags = {
      Name                   = "czr-raas-${var.region_code}-${var.environment}-${var.application}"
      map-migrated           = var.map-migrated-server-id
    }
  depends_on = [
    aws_kms_key.kms_key,
    aws_security_group.msk_security_group
  ]   
}


resource "aws_msk_configuration" "msk_configuration" {
  kafka_versions = ["2.8.1"]
  name           = var.msk_configuration_name

  server_properties = <<PROPERTIES
auto.create.topics.enable=true
default.replication.factor=3
min.insync.replicas=2
num.io.threads=8
num.network.threads=5
num.partitions=1
num.replica.fetchers=2
replica.lag.time.max.ms=30000
socket.receive.buffer.bytes=102400
socket.request.max.bytes=104857600
socket.send.buffer.bytes=102400
unclean.leader.election.enable=true
zookeeper.session.timeout.ms=18000
PROPERTIES
}

resource "aws_msk_scram_secret_association" "secret_association" {
  cluster_arn     = aws_msk_cluster.msk_cluster.arn
  secret_arn_list = [aws_secretsmanager_secret.secrets_msk_secret.arn]
  depends_on = [
    aws_msk_cluster.msk_cluster,
    aws_secretsmanager_secret.secrets_msk_secret
    ]

} 

