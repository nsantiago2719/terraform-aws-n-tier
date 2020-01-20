variable "name" {
  type        = string
  description = "name of the elb"
}

variable "instance-ids" {
  type        = list(string)
  description = "list of instances to be attached on the elb"
}

variable "subnets" {
  type        = list(string)
  description = "A list of subnet IDs to attach to the ELB"
}

variable "security-groups" {
  type        = list(string)
  description = "A list of security group IDs to assign to the ELB."
}

variable "vpc-id" {
  type        = string
  description = "VPC for the load balancer"
}

variable "certificate-arn" {
  type = string
  description = "certificate arn for https connection"
}
