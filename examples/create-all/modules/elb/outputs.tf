output "dns" {
  value = "${aws_lb.elb.dns_name}"
}

output "zone-id" {
  value = "${aws_lb.elb.zone_id}"
}

output "arn" {
  value = "${aws_lb.elb.arn}"
}

output "target-group-arn" {
  value = "${aws_lb_target_group.target-group.arn}"
}

