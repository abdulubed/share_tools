provider "aws" {
  region          = var.region
  assume_role {
    role_arn      = "arn:aws:iam::${var.account}:role/Jenkins-Role"
  }
}


resource "aws_sns_topic" "user_updates1" {
  name = var.sns_topic_name
  delivery_policy = <<EOF
{
  "http": {
    "defaultHealthyRetryPolicy": {
      "minDelayTarget": 20,
      "maxDelayTarget": 20,
      "numRetries": 3,
      "numMaxDelayRetries": 0,
      "numNoDelayRetries": 0,
      "numMinDelayRetries": 0,
      "backoffFunction": "linear"
    },
    "disableSubscriptionOverrides": false
  }
}
EOF
  tags = {
    Name          = var.sns_topic_name
    Environment   = var.environment
    map-migrated  = var.map-migrated-server-id
  }
}

resource "aws_sns_topic_subscription" "email-target" {
  count      = "${length(var.email_ids)}"
  topic_arn  = aws_sns_topic.user_updates1.arn
  protocol   = "email"
  endpoint   = "${var.email_ids[count.index]}"
}