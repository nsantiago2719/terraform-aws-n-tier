output "elb_dns" {
  value = "${module.application-load-balancer.dns}"
}

output "domain" {
  value = "https://${var.sub-domain}.${var.domain-name}"
}
