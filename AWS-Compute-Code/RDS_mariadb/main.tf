provider "aws" {
  region = "us-east-1"

}


module "vpc" {
  source   = "./sample_vpc_code"
  vpc_cidr = "10.0.204.0/23"
  pvt_cidr = ["10.0.204.128/26", "10.0.204.192/26"]
  pub_cidr = ["10.0.204.0/26", "10.0.204.64/26"]
}



module "ALB" {
  source       = "./Load_balancer_only"
  aws_vpc_net  = module.vpc.aws_vpc_id
  pub_subnet01 = module.vpc.vpc_subnet001
  pub_subnet02 = module.vpc.vpc_subnet002


}


module "target_group" {
  source = "./ASG_Launchconfiguration_code"
  dev_vpc = module.vpc.aws_vpc_id
  pub_subnet01 = module.vpc.vpc_subnet001
  pub_subnet02 = module.vpc.vpc_subnet002
  LB_arn = module.ALB.Dev_alb_arn
  
}

module "ASG" {
  source = "./ASG_LaunchConfiguration_code"
  pub_subnet01 = module.vpc.vpc_subnet001
  pub_subnet02 = module.vpc.vpc_subnet002
  dev_vpc = module.vpc.aws_vpc_id
  LB_arn = module.ALB.Dev_alb_arn
 
}

module "RDS-mariadb" {
  source = "./RDS"
  rds_subnet1 = module.vpc.vpc_pvtsubnet001
  rds_subnet2 = module.vpc.vpc_pvtsubnet002
  dev_vpc = module.vpc.aws_vpc_id
  
}
