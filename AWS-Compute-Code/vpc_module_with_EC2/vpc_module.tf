provider "aws" {
  region = "us-east-1"
  
}

terraform {
  backend "s3" {
    bucket = "terraformstatebucket-boraji12-dev"
    key    = "aws-terraform-vpc-dev/terraform.tfstate"
    region = "us-east-1"
  }
}


module "vpc" {
  source   = "./VPC_code"
  vpc_cidr = "10.0.204.0/23"
  pvt_cidr = ["10.0.204.128/26", "10.0.204.192/26"]
  pub_cidr = ["10.0.204.0/26", "10.0.204.64/26"]
}

module "ec2_instance" {
  source = "./EC2"
  security_group = module.vpc.SG_dev_VPC
  pub_subnet = module.vpc.dev_public_subnet
}
