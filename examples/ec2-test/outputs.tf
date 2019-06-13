output "instance-ip" {
  value = "${module.instance.public_ips[0]}"
}
