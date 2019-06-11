output "dns" {
  value = "${aws_lb.elb.dns_name}"
}
