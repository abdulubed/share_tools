provider "aws" {
  region          = var.region
  assume_role {
    role_arn      = "arn:aws:iam::${var.account}:role/Jenkins-Role"
  }
}
 # Network load balancer for kafka:
resource "aws_lb" "aws_nlb" {
  name               = var.lb_name
  internal           = var.internal
  load_balancer_type = "network"
  subnets            = var.subnet_ids
  enable_deletion_protection = var.deletion_protection_enabled

  tags = {
    Environment   = "${var.environment}"
    map-migrated  = var.map-migrated-server-id
    Name          = var.lb_name
  }
}

# Target group for NLB:
resource "aws_lb_target_group" "aws_nlb_tg" {
  name        = var.tg_name
  port        = var.tgport
  protocol    = "TCP"
  vpc_id      = var.vpc_id
  target_type = var.target_type

  tags = {
    Environment   = "${var.environment}"
    map-migrated  = var.map-migrated-server-id
    Name          = var.tg_name
  }  
}

# listener for NLB:
resource "aws_lb_listener" "aws_nlb" {
  load_balancer_arn = aws_lb.aws_nlb.arn
  port              = var.lbport
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.aws_nlb_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "aws_nlb_attach" {
   count            = length(var.instance_list)

   target_id        = var.instance_list[count.index].instance
   port             = var.instance_list[count.index].port
   target_group_arn = aws_lb_target_group.aws_nlb_tg.arn
}
