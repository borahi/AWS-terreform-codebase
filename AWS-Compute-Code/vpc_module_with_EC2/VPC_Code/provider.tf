provider "aws" {
  region     = "us-east-1"
  access_key = "XXXXXXXXXXXXXXXXXXX"
  secret_key = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

data "aws_availability_zones" "available" {

}
