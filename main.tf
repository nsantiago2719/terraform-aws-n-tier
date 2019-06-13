#---------------------------------------------------------------------------------------
# This a template file containing all resources within the modules and uses them to 
# create the needed resources.
#---------------------------------------------------------------------------------------

#---------------------------------------------------------------------------------------
# Terraform version should be used by this template
#---------------------------------------------------------------------------------------
terraform {
  required_version = "0.12.1"
}

#---------------------------------------------------------------------------------------
# The cloud provider configuration. In this case we are using AWS. The default region
# is 'us-east-1'. See https://docs.aws.amazon.com/general/latest/gr/rande.html for more
# regions.
#
# shared_credentials_file contains your access_key and secret_key provided by AWS
#---------------------------------------------------------------------------------------

provider "aws" {
  region = "us-east-1"
  shared_credentials_file = "~/.aws/credentials"
}


#---------------------------------------------------------------------------------------
# Key pairs uploaded in AWS and will be used by the instances for SSH connections
#---------------------------------------------------------------------------------------

resource "aws_key_pair" "key-pair" {
  key_name   = "simple-key-pair"
  public_key = "${file("${path.cwd}/keypair")}"
}

#---------------------------------------------------------------------------------------
# Simple template of VPC that'll be created for the project.
# Parameters:
#
# vpc-cidr-block      = CIDR block for the VPC. Default 10.0.0.0/16 (optional)
# project             = Project name of the VPC. Default simple-project (optional)
# public-subnet-cidr  = CIDR block for public subnets. Default ["10.0.1.0/24",
                                                                "10.0.5.0/24",
                                                                "10.0.10.0/24"] (optional)
#
# private-subnet-cidr = CIDR block for private subnets. Default ["10.0.21.0/24",
                                                                 "10.0.25.0/24",
                                                                 "10.0.30.0/24"] (optional)
#---------------------------------------------------------------------------------------
module "project-vpc" {
  source = "./modules/vpc"
}

module "security-group-public" {
  source = "./modules/security-groups"

  name = "simple-project-default"
  description = "allow port 80"
  vpc-id = "${module.project-vpc.vpc-id}"
  ingress-ports = ["80", "443"]
  allowed-cidr-block = ["0.0.0.0/0"]
}

module "security-group-instance" {
  source = "./modules/security-groups"

  name = "simple-project-sg"
  description = "allow port 80"
  vpc-id = "${module.project-vpc.vpc-id}"
  ingress-ports = ["80"]
  security-group-ids = ["${module.security-group-public.id}"]
}

module "instance-cluster-private" {
  source = "./modules/ec2"

  desired-instance = 3
  project = "simple-project"
  subnet-ids = "${module.project-vpc.private-subnet-ids}"
  security-group-ids = ["${module.security-group-instance.id}"]
  vpc-id = "${module.project-vpc.vpc-id}"
  key-pair = "${aws_key_pair.key-pair.key_name}"
  user-data = "${file("${path.cwd}/modules/install_nginx/install")}"
}

module "elb" {
  source = "./modules/elb"

  name = "simple-project-elb"
  instance-ids = "${module.instances.ids}"
  subnets = "${module.project-vpc.public-subnet-ids}"
  security-groups = ["${module.security-group-public.id}"]
  vpc-id = "${module.project-vpc.vpc-id}"
  certificate-arn = "${var.certificate-arn}"
}


