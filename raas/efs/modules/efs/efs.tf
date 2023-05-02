provider "aws" {
  region          = var.region
  assume_role {
    role_arn      = "arn:aws:iam::${var.account}:role/Jenkins-Role"
  }
}

resource "aws_security_group" "efs" {
  name        = "RaaS-${var.environment}-EFS-sg"
  description = "Allow EKS to access EFS"
  vpc_id      = var.vpc_id

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags = {
    Name = "RaaS-${var.environment}-EFS-sg"
    map-migrated = var.map-migrated
  }
}

resource "aws_security_group_rule" "ingress_rules" {
  count = length(var.efs_ingress_rules)

  type              = "ingress"
  from_port         = var.efs_ingress_rules[count.index].from_port
  to_port           = var.efs_ingress_rules[count.index].to_port
  protocol          = var.efs_ingress_rules[count.index].protocol
  cidr_blocks       = [var.efs_ingress_rules[count.index].cidr_block]
  description       = var.efs_ingress_rules[count.index].description
  security_group_id = aws_security_group.efs.id
}


resource "aws_efs_file_system" "raas_efs" {
  creation_token      = var.creation_token 
  encrypted           = var.encrypted
  performance_mode    = var.performance_mode
  throughput_mode     = var.throughput_mode

  lifecycle_policy {
    transition_to_primary_storage_class = var.out_of_IA
  }
  lifecycle_policy {
    transition_to_ia = var.into_IA
  }

  tags = {
    /* Name = "RaaS-${var.environment}-EFS" */
    Name = var.creation_token
    map-migrated = var.map-migrated
  }
}

resource "aws_efs_backup_policy" "automatic_backup" {
  file_system_id = aws_efs_file_system.raas_efs.id

  backup_policy {
    status = "ENABLED"
  }
}

resource "aws_efs_mount_target" "efs_network" {
  count          = length(var.subnet_ids)
  file_system_id = join("", aws_efs_file_system.raas_efs.*.id)
  subnet_id      = var.subnet_ids[count.index]
  security_groups = ["${aws_security_group.efs.id}", var.associated_security_group_id]
}