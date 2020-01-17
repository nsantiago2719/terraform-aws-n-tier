variable "subdomain" {
  type        = string
  description = "Sub-domain name for the architecture"
}

variable "hosted-zone-name" {
  type        = string
  description = "Hosted zone name of the architecture"
}

variable "lb-dns" {
  type        = string
  description = "Load balancer DNS to be attached on the DNS A Record "
}

variable "lb-zone-id" {
  type        = string
  description = "Load balancer zone id"
}

