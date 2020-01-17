#---------------------------------------------------------------------------------------
# Terraform version should be used by this template
#---------------------------------------------------------------------------------------
terraform {
  required_version = "0.12.1"
}

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc-cidr-block

  tags = {
    Name = "vpc-${var.project}"
  }
}

module "public_subnet" {
  source = "./modules/subnets"

  project                    = "simple-project"
  name                       = "public-subnet"
  vpc-id                     = aws_vpc.vpc.id
  cidr-block                 = var.public-subnet-cidr
  public                     = true
  aws-default-route-table-id = aws_vpc.vpc.default_route_table_id
}

