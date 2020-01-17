variable "subnets" {
  type        = "list"
  description = "list of subnets added to the route table association"
}

variable "vpc-id" {
  type        = "string"
  description = "VPC Id assigned in the route table"
}

variable "project" {
  type        = "string"
  description = "Project where the route table is under"
}

variable "cidr-block" {
  type        = "string"
  description = "CIDR Block to be added on route table"
}

variable "nat-gateway-id" {
  type        = "string"
  description = "NAT Gateway ID to be added on route table"
  default     = ""
}

variable "network-interface-id" {
  type        = "string"
  description = "Network interface to be added on route"
  default     = ""
}

variable "instance-id" {
  type        = "string"
  description = "Instance to be added on route"
  default     = ""
}

variable "gateway-id" {
  type        = "string"
  description = "Internet Gateway to be added on route"
  default     = ""
}
