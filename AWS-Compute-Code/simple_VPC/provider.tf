provider "aws" {
  region     = "us-east-1"
  access_key = "XXXXXXXXXXXXXX"
  secret_key = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

data "aws_availability_zones" "available" {

}

terraform {
  backend "s3" {
    bucket = "terraformstatebucket-boraji12-dev"
    key    = "aws-terraform-vpc-dev/terraform.tfstate"
    region = "us-east-1"
  }
}