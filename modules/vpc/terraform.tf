variable "vpc-cidr-block" {
  type = "string"
  description = "CIDR block stated for the VPC"
  default = "10.0.0.0/16"
}

variable "project" {
  type = "string"
  description = "Project name of the VPC"
  default = "simple-project"
}

variable "environment" {
  type = "string"
  description = "Specific workspace where the VPC is created"
  default = "development"
}
