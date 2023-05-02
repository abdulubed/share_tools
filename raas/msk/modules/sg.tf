## ec2 security group
resource "aws_security_group" "msk_security_group" {
  name                     = "czr-raas-security-group-${var.region_code}-${var.environment}-${var.application}"
  description              = "ec2 custom security group"
  vpc_id                   = var.vpc_id

  egress {
    from_port              = 0
    to_port                = 0
    protocol               = "-1"
    cidr_blocks            = ["0.0.0.0/0"]
    ipv6_cidr_blocks       = ["::/0"]
  }
  tags = {
    Name                   = "czr-raas-security-group-${var.region_code}-${var.environment}-${var.application}"
    Environment            = var.environment
    map-migrated           = var.map-migrated-server-id
  }
}

resource "aws_security_group_rule" "sg_ingress_rules_cidr" {
  count = length(var.sg_ingress_rules_cidr)

  type                     = "ingress"
  from_port                = var.sg_ingress_rules_cidr[count.index].from_port
  to_port                  = var.sg_ingress_rules_cidr[count.index].to_port
  protocol                 = var.sg_ingress_rules_cidr[count.index].protocol
  cidr_blocks              = var.sg_ingress_rules_cidr[count.index].cidr_block
  description              = var.sg_ingress_rules_cidr[count.index].description
  security_group_id        = aws_security_group.msk_security_group.id
}