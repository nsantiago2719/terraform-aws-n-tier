variable "subnet-ids" {
  type        = "list"
  description = "List of subnets that is going to be use by the instance"
}

variable "project" {
  type        = "string"
  description = "Project where the instance belong"
  default     = "simple-project"
}

variable "key-pair" {
  type        = "string"
  description = "Allowed public key pair name on the instance"
}

variable "user-data" {
  type        = "string"
  description = "User data in string to be executed upon initializing the instance"
}

variable "desired-instance" {
  type        = number
  description = "desired instance to be deployed across the given subnets"
  default     = 3
}

variable "security-group-ids" {
  type        = "list"
  description = "list of security group ids to be used in the instance"
}
