#---------------------------------------------------------------------------------------
# Terraform version should be used by this template
#---------------------------------------------------------------------------------------
terraform {
  required_version = "0.12.1"
}

resource "aws_vpc" "vpc" {

  cidr_block = "${var.vpc-cidr-block}"

  tags = {
    Name        = "vpc-${var.project}"
  }
}

module "public_subnet" {
  source                     = "./modules/subnets"

  project                    = "simple-project"
  name                       = "public-subnet"
  vpc-id                     = "${aws_vpc.vpc.id}"
  cidr-block                 = ["10.0.1.0/24", "10.0.5.0/24", "10.0.10.0/24"]
  public                     = true
  aws-default-route-table-id = "${aws_vpc.vpc.default_route_table_id}"
}

module "private_subnet" {
  source                     = "./modules/subnets"

  project                    = "simple-project"
  name                       = "private-subnet"
  vpc-id                     = "${aws_vpc.vpc.id}"
  cidr-block                 = ["10.0.21.0/24", "10.0.25.0/24", "10.0.30.0/24"]
  public                     = false
}

module "nat-gateway" {
  source           = "./modules/nat"
  public-subnet-id = "${element(module.public_subnet.subnet-ids, 0)}"
}

module "route-table-associations-private" {
  source         = "./modules/route-tables"

  subnets        = "${module.private_subnet.subnet-ids}"
  vpc-id         = "${aws_vpc.vpc.id}"
  project        = "simple-project"
  cidr-block     = "0.0.0.0/0"
  nat-gateway-id = "${module.nat-gateway.id}"
}

