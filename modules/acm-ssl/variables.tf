variable "domain" {
  type        = string
  description = "Domain name for the architecture"
}

variable "hosted-zone-name" {
  type        = string
  description = "Hosted zone name of the architecture"
}

variable "alternative-names" {
  type        = list(string)
  description = "list of alternative names for the certificate"
  default     = []
}

