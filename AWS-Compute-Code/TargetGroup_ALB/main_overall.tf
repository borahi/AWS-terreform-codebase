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
  source         = "./EC2_Code"
  security_group = module.vpc.SG_dev_VPC
  pub_subnet     = module.vpc.dev_public_subnet

}

module "Target_group" {
  source      = "./Load_balancer_only"
  aws_vpc_net = module.vpc.aws_vpc_id
  Target_instance1 = module.ec2_instance.aws_instance1
  Target_instance2 = module.ec2_instance.aws_instance2
  pub_subnet01 = module.vpc.vpc_subnet001
  pub_subnet02 = module.vpc.vpc_subnet002

}

module "ALB" {
  source = "./Load_balancer_only"
  aws_vpc_net = module.vpc.aws_vpc_id
  Target_instance1 = module.ec2_instance.aws_instance1
  Target_instance2 = module.ec2_instance.aws_instance2
  pub_subnet01 = module.vpc.vpc_subnet001
  pub_subnet02 = module.vpc.vpc_subnet002

  
}
