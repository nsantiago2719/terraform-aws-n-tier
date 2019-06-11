variable "project" {
  type = "string"
  description = "The project where this subnet is in"
}

variable "name" {
  type = "string"
  description = "Subnet tag name"
}

variable "vpc-id" {
  type = "string"
  description = "Id of the VPC where the subnets is created"
}

variable "cidr-block" {
  type = "list"
  description = "CIDR block used by the subnet"
}

variable "public" {
  type = bool
  description = "Determines if the subnet to be created will be public or private"
}

variable "subnet-counts" {
  type = number
  description = "Number of subnets created. This should align on how many available AZ on the region you chose"
  default = 1
}

variable "aws-default-route-table-id" {
  type = "string"
  description = "Default route table id generated. Required if public is true"
}

variable "public-subnet-id" {
  type = "string"
  description = "Public subnet id for nat gateway. Requried if public is false"
  default = ""
}
