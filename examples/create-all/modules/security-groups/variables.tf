variable "name" {
  type        = "string"
  description = "Name provided for the security group"
}

variable "description" {
  type        = "string"
  description = "Description for the security group"
}

variable "vpc-id" {
  type        = "string"
  description = "VPC where the security group that located"
}

variable "ingress-ports" {
  type        = "list"
  description = "List of ingress ports of the security group"
  default     = ["80"]
}

variable "allowed-cidr-block" {
  type        = "list"
  description = "List of allowed CIDR block on the security group"
  default     = []
}
variable "security-group-ids" {
  type        = "list"
  description = "List of allowed security group on the security group"
  default     = []

}
