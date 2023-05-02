resource "aws_iam_role" "iam_role" {
  name = var.iam_role_name
  assume_role_policy = jsonencode({
   "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
})
  tags = {
    Name                   = "czr-raas-iam-${var.environment}-${var.application}-role"
    Environment            = var.environment
    map-migrated           = var.map-migrated-server-id
  }
}

# Then parse through the list using count
resource "aws_iam_role_policy_attachment" "role-policy-attachment" {
  role        = aws_iam_role.iam_role.name
  count      = "${length(var.iam_policy_arn)}"
  policy_arn = "${var.iam_policy_arn[count.index]}"
}

resource "aws_iam_instance_profile" "instance_profile" {
    depends_on = [ 
     aws_iam_role.iam_role,
     aws_iam_role_policy_attachment.role-policy-attachment
     ]
  name = var.iam_profile_name
  role        = aws_iam_role.iam_role.name
}