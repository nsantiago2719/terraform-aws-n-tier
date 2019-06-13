# ---------------------------------------------------------------------------------------
#
# This a template file containing all resources within the modules and uses them to
# create the needed resources.
#
# ---------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------
#
# Terraform version should be used by this template
#
# ---------------------------------------------------------------------------------------
terraform {
  required_version = "0.12.1"
}


# ---------------------------------------------------------------------------------------
#
# The cloud provider configuration. In this case we are using AWS. The default region
# is 'us-east-1'. See https://docs.aws.amazon.com/general/latest/gr/rande.html for more
# regions.
#
# shared_credentials_file contains your access_key and secret_key provided by AWS. Usually
# it is stored on the path used below. Change it to the path where the credential is located
#
# ---------------------------------------------------------------------------------------
provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = "~/.aws/credentials"
}

# ---------------------------------------------------------------------------------------
#
# Key pairs uploaded in AWS and will be used by the instances for SSH connections
# Filename keypair that is located at the same directory with this
# template is used.
#
# ---------------------------------------------------------------------------------------

resource "aws_key_pair" "key-pair" {
  key_name   = "simple-key-pair"
  public_key = "${file("${path.cwd}/keypair")}"
}

# ---------------------------------------------------------------------------------------
#
# Simple template of VPC that'll be created for the project.
# Parameters:
#
# vpc-cidr-block      = CIDR block for the VPC. Default 10.0.0.0/16 (optional)
# project             = Project name of the VPC. Default simple-project (optional)
# public-subnet-cidr  = CIDR block for public subnets. Default ["10.0.1.0/24",
#                                                               "10.0.5.0/24",
#                                                               "10.0.10.0/24"] (optional)
#
# private-subnet-cidr = CIDR block for private subnets. Default ["10.0.21.0/24",
#                                                                "10.0.25.0/24",
#                                                                "10.0.30.0/24"] (optional)
#
# ---------------------------------------------------------------------------------------
module "project-vpc" {
  source = "./modules/vpc"
}

#---------------------------------------------------------------------------------------
#
# Security groups that is publicly and privately accessible.
# security-group-public open port 80 and 443 to 0.0.0.0/0.
#
# Parameters:
#
# name               = Name to be provided for the security group. Required
# description        = Description for the security group. (optional)
# vpc-id             = VPC where the security group is attached. Required
# ingress-ports      = List of ingress ports to be allowed in the public group. Default ["80"]
# allowed-cidr-block = List of CIDR block allowed on the security group. Default []
#                      Required if security-group-ids is [].
# security-group-ids = List of Security Group ids allowed on the security group. Default []
#                      Required if allowed-cidr-block is [].
#
#---------------------------------------------------------------------------------------
module "security-group-public" {
  source = "./modules/security-groups"

  name               = "simple-project-default"
  description        = "allow port 80"
  vpc-id             = "${module.project-vpc.vpc-id}"
  ingress-ports      = ["80", "443"]
  allowed-cidr-block = ["0.0.0.0/0"]
}
#---------------------------------------------------------------------------------------
#
# Instance cluster deployed in private subnet. It is also possible to create publicly
# accessible instances by changing the subnet and subnets being used by the instance.
# Instances created through this template has a t2.micro instance type.
#
# Parameters:
# subnet-ids         = List of subnets that is going to be use by the instance. Required
# project            = Project where the instance belong. Default simple-project. Optional
# key-pair           = Allowed public key pair name to be assigned on the instance. Required
# user-data          = User data in string to be executed upon initializing the instance. Optional
# desired-instance   = Desired instance to be deployed across the given subnets. Default 3
# security-group-ids = list of security group ids to be attached to the intances. Required
#
#---------------------------------------------------------------------------------------
module "instance" {
  source = "./modules/ec2"

  desired-instance   = 1
  project            = "simple-project"
  subnet-ids         = "${module.project-vpc.public-subnet-ids}"
  security-group-ids = ["${module.security-group-public.id}"]
  key-pair           = "${aws_key_pair.key-pair.key_name}"
  user-data          = "${file("${path.cwd}/modules/install_nginx/install")}"
}

