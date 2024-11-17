provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "Dev_LaunchConfSG001" {
  vpc_id = var.dev_vpc
  tags = {
    "Name" = "BU1_LConf_SG01"
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

resource "aws_launch_configuration" "ASG_launch" {
    name = "Dev-asg001-LaunchConf001"
    image_id = "ami-0bda77bcded5d4a4c"
    instance_type = "t2.micro"
    
    user_data = <<-EOF
    #!/bin/bash
    yum -y install httpd
    echo "Hello World!! This is terraform AWS Test page" >> /var/www/html/index.html
    service httpd start
    chkconfig httpd on
    EOF
    security_groups = [aws_security_group.Dev_LaunchConfSG001.id]
    key_name = "BU01_dev_key"

    lifecycle{
      create_before_destroy = true
    }


}

################ ALB Target Group ####################

resource "aws_lb_target_group" "dev_TG001" {

  name = "Dev-TargetGp001"
  target_type = "instance"
  protocol = "HTTP"
  port = 80
  vpc_id = var.dev_vpc

  health_check {
    interval = 10
      path = "/"
      protocol = "HTTP"
      timeout = 5
      healthy_threshold = 3
      unhealthy_threshold = 2
  }
  
}

resource "aws_alb_listener" "Dev-LB001-listener" {
  load_balancer_arn = var.LB_arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.dev_TG001.arn
  }
  
}


############## se3curity Group ###############

resource "aws_security_group" "Dev_Security001" {
  vpc_id = var.dev_vpc

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

######################## ASG ################################

resource "aws_autoscaling_group" "Dev-ASG001" {

    name = "Dev-Auto-ScaleGroup001"
    launch_configuration = aws_launch_configuration.ASG_launch.id
    vpc_zone_identifier = [ var.pub_subnet01, var.pub_subnet02 ]
    target_group_arns = [aws_lb_target_group.dev_TG001.arn]
    health_check_type = "ELB"

    min_size = 2
    max_size = 4
      
}


