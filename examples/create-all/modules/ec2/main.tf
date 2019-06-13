#---------------------------------------------------------------------------------------
# Terraform version should be used by this template
#---------------------------------------------------------------------------------------
terraform {
  required_version = "0.12.1"
}

resource "aws_instance" "instances" {
  count = "${var.desired-instance}"

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
