output "instance-url" {
  value = "http://${module.instance.public_ips[0]}/"
}

