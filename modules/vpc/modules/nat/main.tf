resource "aws_eip" "nat-eip" {
}

resource "aws_nat_gateway" "private-nat-gateway" {
  subnet_id     = "${var.public-subnet-id}"
  allocation_id = "${aws_eip.nat-eip.id}"
}

variable "public-subnet-id" {
  type        = "string"
  description = "public subnet where the nat gateway is attached"
}

output "id" {
  value = "${aws_nat_gateway.private-nat-gateway.id}"
}
