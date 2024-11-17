provider "aws" {
  region     = "us-east-1"
  access_key = "xxxxxxxxxxxxxxx"
  secret_key = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}

data "aws_availability_zones" "available" {

}

