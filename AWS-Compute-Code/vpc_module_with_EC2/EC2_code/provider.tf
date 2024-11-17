provider "aws" {
    region = "us-east-1"
}

data "aws_availability_zones" "available_zones" {
  
  }


data "aws_ami" "Amazon_images" {
    most_recent = true
    owners = ["amazon"]

    filter {
      name = "name"
      values = ["amzn2-ami-hvm-2.0*"]

    }

    filter {
      name = "virtualization-type"
      values = ["hvm"]
    }

   
    filter {
      name = "root-device-type"
      values = ["ebs"]
    }

}

