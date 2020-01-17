variable "domain" {
  type        = "string"
  description = "Domain name for the architecture"
}

variable "hosted-zone-name" {
  type        = "string"
  description = "Hosted zone name of the architecture"
}

variable "alternative-names" {
  type        = "list"
  description = "list of alternative names for the certificate"
}

variable "elb-arn" {
  type        = "string"
  description = "Load balancer ARN for HTTPS listner"
}

variable "target-group-arn" {
  type        = "string"
  description = "Target group ARN declared on the load balancer"
}
