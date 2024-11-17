provider "aws"{
  region = "us-east-1"
  
}


resource "aws_alb_target_group" "BU01-Dev-Traget-group" {

    name = "BU01-Dev-ALB-tg001"
    target_type = "instance"
    protocol = "HTTP"
    port = "80"
    vpc_id = var.aws_vpc_net

    health_check {
      interval = 25
      path = "/"
      protocol = "HTTP"
      timeout = 5
      healthy_threshold = 3
      unhealthy_threshold = 2
    }
  
}

#### Before target attachmenet make sure the taget (EC2) must be power on and running state #####

resource "aws_alb_target_group_attachment" "BU01-dev-Taget01-attach" {
  target_group_arn = aws_alb_target_group.BU01-Dev-Traget-group.arn
  target_id = var.Target_instance1
  port = 80

}


resource "aws_alb_target_group_attachment" "BU01-dev-Taget02-attach" {
  target_group_arn = aws_alb_target_group.BU01-Dev-Traget-group.arn
  target_id = var.Target_instance2
  port = 80

}

############## ALB se3curity Group ###############

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

resource "aws_alb_listener" "Dev-LB001-listener" {
  load_balancer_arn = aws_lb.Dev-LB001.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_alb_target_group.BU01-Dev-Traget-group.arn
  }
  
}


