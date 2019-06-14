output "ids" {
  value = "${aws_instance.instances.*.id}"
}

output "public-ips" {
  value = "${aws_instance.instances.*.public_ip}"
}
