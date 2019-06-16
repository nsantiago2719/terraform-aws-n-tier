#---------------------------------------------------------------------------------------
# Terraform version should be used by this template
#---------------------------------------------------------------------------------------
terraform {
  required_version = ">= 0.12.1,<= 0.12.5"

  required_providers {
    aws = "~> 2.15.0"
  }
}

resource "aws_security_group" "security-group" {
  name = "${var.name}-group"
  description = "${var.description}"
  vpc_id      = "${var.vpc-id}"

  dynamic "ingress" {
    for_each = var.ingress-ports

    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = "${var.allowed-cidr-block}"
      security_groups = "${var.security-group-ids}"
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
    description = "allow all outbound traffic"
  }
}

