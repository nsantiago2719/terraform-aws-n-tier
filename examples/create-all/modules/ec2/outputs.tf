output "ids" {
  value = "${aws_instance.instances.*.id}"
}
