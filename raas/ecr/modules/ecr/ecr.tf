provider "aws" {
  region          = var.region
  // profile         = var.account
  assume_role {
    role_arn      = "arn:aws:iam::${var.account}:role/Jenkins-Role"
  }
}

resource "aws_ecr_repository" "czr_raas_pdb_keychain_ecr" {
  count = "${length(var.ecr_list)}"
  name = "${element(var.ecr_list, count.index)}"

  image_tag_mutability = var.mutability
  encryption_configuration {
    encryption_type = "AES256"
  }
  tags = {
    Name = "${element(var.ecr_list, count.index)}"
    Environment = var.environment
    map-migrated = var.map-migrated-server-id
  }
}

resource "aws_ecr_repository_policy" "czr_raas_pdb_keychain_ecr_policy" {
  count = "${length(var.ecr_list)}"
  repository = "${element(var.ecr_list, count.index)}"

  policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "AllowPushPull",
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "arn:aws:iam::046638516000:role/Jenkins-Role",
          "arn:aws:iam::741762191802:root",
          "arn:aws:iam::563814137075:root",
          "arn:aws:iam::353991931672:root",
          "arn:aws:iam::574299803363:root",
          "arn:aws:iam::586467197160:root",
          "arn:aws:iam::238837397276:root"
        ]
      },
      "Action": [
        "ecr:BatchCheckLayerAvailability",
        "ecr:BatchGetImage",
        "ecr:CompleteLayerUpload",
        "ecr:GetDownloadUrlForLayer",
        "ecr:InitiateLayerUpload",
        "ecr:PutImage",
        "ecr:UploadLayerPart"
      ]
    }
  ]
}
EOF
}