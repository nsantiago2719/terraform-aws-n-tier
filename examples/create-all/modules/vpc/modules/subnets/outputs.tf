output "subnet-ids" {
  value = "${aws_subnet.subnets.*.id}"
}
