output "vpc-id" {
  value = "${aws_vpc.vpc.id}"
}

output "default-route-table-id" {
  value = "${aws_vpc.vpc.default_route_table_id}"
}

output "public-subnet-ids" {
  value = "${module.public_subnet.subnet-ids}"
}

