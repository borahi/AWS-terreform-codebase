
provider "aws" {
  region = "us-east-1"
}


resource "aws_db_instance" "dev-rds-mariadb001" {
    engine = "mariadb"
    engine_version = "10.5.12"
    name = "mymariadb"
    multi_az = false
    username = "admin"
    password = "Redhat123"
    allocated_storage = 10
    instance_class = "db.t2.micro"
    storage_type = "gp2"
    backup_retention_period = 10
    backup_window = "11:00-12:00"
    db_subnet_group_name = aws_db_subnet_group.my-rds-db-subnet.name
    vpc_security_group_ids = [ aws_security_group.rds_Security002.id ]

  
}

resource "aws_db_subnet_group" "my-rds-db-subnet" {
  name       = "my-rds-db-subnet"
  subnet_ids = [var.rds_subnet1, var.rds_subnet2]
}


resource "aws_security_group" "rds_Security002" {
  vpc_id = var.dev_vpc

  tags = {
    "Name" = "BU1_LB-vpc_SG01"
  }

  ingress = [{
    "cidr_blocks" : [
      "0.0.0.0/0"
    ],
    "description" : "ssh access to the machine",
    "from_port" : 3306,
    "ipv6_cidr_blocks" : [],
    "prefix_list_ids" : [],
    "protocol" : "tcp",
    "security_groups" : [],
    "self" : false,
    "to_port" : 3306

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
