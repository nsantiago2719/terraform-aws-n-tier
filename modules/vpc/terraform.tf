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

variable "public-subnet-cidr" {
  type = "list"
  description = "CIDR block for public subnets"
  default = ["10.0.1.0/24", "10.0.5.0/24", "10.0.10.0/24"]
}

variable "private-subnet-cidr" {
  type = "list"
  description = "CIDR block for private subnets"
  default = ["10.0.21.0/24", "10.0.25.0/24", "10.0.30.0/24"]
}

