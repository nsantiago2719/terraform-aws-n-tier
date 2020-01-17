data "aws_availability_zones" "available" {}

resource "aws_subnet" "subnets" {
  count = "${length(var.cidr-block)}"

  cidr_block = "${element(var.cidr-block, count.index)}"
  vpc_id     = "${var.vpc-id}"

  map_public_ip_on_launch = "${var.public}"

  availability_zone = "${element(data.aws_availability_zones.available.names, count.index)}"

  tags = {
    Name = "${var.name}-${count.index}"
  }
}

resource "aws_default_route_table" "default-route-table-association" {
  count = "${var.public ? 1 : 0}"

  default_route_table_id = "${var.aws-default-route-table-id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw[0].id}"
  }
}

resource "aws_internet_gateway" "igw" {
  count  = "${var.public ? 1 : 0}"
  vpc_id = "${var.vpc-id}"

  tags = {
    Name = "igw-${var.project}"
  }
}
