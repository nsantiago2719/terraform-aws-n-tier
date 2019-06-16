#---------------------------------------------------------------------------------------
# Terraform version should be used by this template
#---------------------------------------------------------------------------------------
terraform {
  required_version = ">= 0.12.1,<= 0.12.5"

  required_providers {
    aws = "~> 2.15.0"
  }
}

resource "aws_instance" "instances" {
  count = "${var.desired-instance}"

# NOTE: AMI and instance should be declared by the user. This should be updated rather
# than using a variable for now.
  ami                    = "ami-0c6b1d09930fac512"
  instance_type          = "t2.micro"
  key_name               = "${var.key-pair}"
  subnet_id              = "${element(var.subnet-ids, count.index)}"
  vpc_security_group_ids = "${var.security-group-ids}"
  user_data              = "${var.user-data}"

  tags = {
    Name = "${var.project}-instance"
  }
}
