variable "subnet-ids" {
  type        = "list"
  description = "List of subnets that is going to be use by the instance"
}

variable "vpc-id" {
  type        = "string"
  description = "VPC ID for the security group instance"
}

variable "project" {
  type        = "string"
  description = "Subnet that is going to be use by the instance"
  default     = "simple-project"
}

variable "key-pair" {
  type        = "string"
  description = "Allowed public key pair name on the instance"
}

variable "user-data" {
  type        = "string"
  description = "User data to be executed upon creation of the instance"
}

variable "desired-instance" {
  type = number
  description = "desired instance to be deployed across subnets given"
  default = 3
}

variable "security-group-ids" {
  type = "list"
  description = "list of security group ids to be used in the instance"
}
