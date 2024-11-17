provider "aws"{
  region = "us-east-1"
  
}



############## ALB security Group ###############

resource "aws_security_group" "Dev_LBSecurity001" {
  vpc_id = var.aws_vpc_net

  tags = {
    "Name" = "BU1_LB-vpc_SG01"
  }

  ingress = [{
    "cidr_blocks" : [
      "0.0.0.0/0"
    ],
    "description" : "ssh access to the machine",
    "from_port" : 22,
    "ipv6_cidr_blocks" : [],
    "prefix_list_ids" : [],
    "protocol" : "tcp",
    "security_groups" : [],
    "self" : false,
    "to_port" : 22

  },
  {
    "cidr_blocks" : [
      "0.0.0.0/0"
    ],
    "description" : "web access to the machine",
    "from_port" : 80,
    "ipv6_cidr_blocks" : [],
    "prefix_list_ids" : [],
    "protocol" : "tcp",
    "security_groups" : [],
    "self" : false,
    "to_port" : 80


  }]

  egress = [
    {
      "cidr_blocks" : [
        "0.0.0.0/0"
      ],
      "description" : "",
      "from_port" : 0,
      "ipv6_cidr_blocks" : [],
      "prefix_list_ids" : [],
      "protocol" : "-1",
      "security_groups" : [],
      "self" : false,
      "to_port" : 0
  }]  

}

############## ALB ##################

resource "aws_lb" "Dev-LB001" {
  name = "Dev-Application-LB001"
  internal = false
  ip_address_type = "ipv4"
  subnets = [var.pub_subnet01, var.pub_subnet02]
  load_balancer_type = "application"
  security_groups = [aws_security_group.Dev_LBSecurity001.id]



}

output "Dev_alb_arn" {
  value = aws_lb.Dev-LB001.arn  
}


