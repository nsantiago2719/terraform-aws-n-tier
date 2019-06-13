output "elb_dns" {
  value = "${module.application-load-balancer.dns}"
}
