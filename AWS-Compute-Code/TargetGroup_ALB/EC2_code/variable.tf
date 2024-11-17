variable "aws_instance_type" {
   default = "t2.micro"
}

variable "security_group" {}

variable "pub_subnet"{
   type = list(any)
}

