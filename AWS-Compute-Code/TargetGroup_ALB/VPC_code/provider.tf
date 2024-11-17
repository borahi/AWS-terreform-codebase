provider "aws" {
  region     = "us-east-1"
  access_key = "XXXXXXXXXXXXXXXX"
  secret_key = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

data "aws_availability_zones" "available" {

}

