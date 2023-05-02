provider "aws" {
  region          = var.region
  assume_role {
    role_arn      = "arn:aws:iam::${var.account}:role/Jenkins-Role"
  }
}

resource "aws_instance" "instance" {
  ami                        = var.aws_ami
  instance_type              = var.instance_type
  vpc_security_group_ids     = [aws_security_group.ec2_security_group.id]
  subnet_id                  = var.subnet_id
  key_name                   = var.key_pair
  disable_api_termination    = false

  root_block_device {
    encrypted                = "false"
    delete_on_termination    = true
    volume_size              = var.root_device_size
    volume_type              = var.root_device_type    
    tags = {
      Name                   = "czr-ebs-${var.region_code}-${var.environment}-${var.application}-root"
      map-migrated           = var.map-migrated-server-id
    }    
  }


  tags = {
    Name                     = "czr-ec2-${var.region_code}-${var.environment}-${var.application}"
    Environment              = var.environment
    map-migrated             = var.map-migrated-server-id
    created-by               = var.created-by
    contact-person           = var.contact-person
  }
  iam_instance_profile       = var.existing_iam_profile_name
}

## ebs volumes
resource "aws_ebs_volume" "ebs_volume" {
  count             = "${length(var.additional_device_size)}"
  availability_zone = var.availability_zone
  size              = "${element(var.additional_device_size, count.index)}"
   tags = {
    Name            = "czr-ebs-${var.region_code}-${var.environment}-${var.application}-${element(var.additional_device_tag, count.index)}"
    Environment     = var.environment
    map-migrated    = var.map-migrated-server-id
  }
}

resource "aws_volume_attachment" "ebs_attachment" {
  depends_on = [
    aws_ebs_volume.ebs_volume,
    aws_instance.instance
  ]

  count       = "${length(var.additional_device_size)}"
  device_name = "${element(var.additional_device_name, count.index)}"
  volume_id   = "${aws_ebs_volume.ebs_volume.*.id[count.index]}"
  instance_id = aws_instance.instance.id
}