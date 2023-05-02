provider "aws" {
  region          = var.region
  assume_role {
    role_arn      = "arn:aws:iam::${var.account}:role/Jenkins-Role"
  }
}

resource "aws_acm_certificate" "cert" {
  count             = "${length(var.domain_name)}"
  domain_name       = "${element(var.domain_name, count.index)}"
  validation_method = var.validation_method

  tags = {
    Name = var.acm_certificate_name
    Environment = var.environment
    map-migrated = var.map-migrated-server-id
  }

  lifecycle {
    create_before_destroy = true
  }
}