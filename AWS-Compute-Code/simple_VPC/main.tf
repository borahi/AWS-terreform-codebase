
####################### VPC ###########################

resource "aws_vpc" "dev_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = "true"
  enable_dns_support   = "true"
  tags = {
    Name = "BU1-dev-vpc"
  }
}

########################### Internet Gateway ##############################

resource "aws_internet_gateway" "dev_igw" {
  vpc_id = aws_vpc.dev_vpc.id

  tags = {
    Name = "Bu1-dev-igw"
  }
}

############################# Pub Route-table ###########################

resource "aws_route_table" "pub_route" {
  vpc_id = aws_vpc.dev_vpc.id

  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.dev_igw.id
    }

  tags = {
    Name = "BU1-dev-pub-rt01"
  }

}

############################# Pvt Route-table #############################

resource "aws_route_table" "pvt_route" {
  vpc_id = aws_vpc.dev_vpc.id

  tags = {
    Name = "BU1-dev-pvt-rt01"
  }
}


########################### Private Subnets ###############################

resource "aws_subnet" "pvt-sub001" {
  count             = 2
  cidr_block        = var.pvt_cidr[count.index]
  vpc_id            = aws_vpc.dev_vpc.id
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    "Name" = "BU1-dev-pvt-subnet.${count.index + 1}"
  }
}


########################### Public Subnets ###################################

resource "aws_subnet" "pub-subnet" {
  count                   = 2
  cidr_block              = var.pub_cidr[count.index]
  vpc_id                  = aws_vpc.dev_vpc.id
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = {
    "Name" = "BU1-dev-pub-subnet.${count.index + 1}"
  }

}

############################# subnet mapping ###################################

resource "aws_route_table_association" "public-sub-accociate" {
  count          = 2
  route_table_id = aws_route_table.pub_route.id
  subnet_id      = aws_subnet.pub-subnet.*.id[count.index]


}

resource "aws_route_table_association" "pvt-sub-associate" {
  count          = 2
  route_table_id = aws_route_table.pvt_route.id
  subnet_id      = aws_subnet.pvt-sub001.*.id[count.index]

}

############################  service Profile ######################################

resource "aws_security_group" "Security001" {
  vpc_id = aws_vpc.dev_vpc.id

  tags = {
    "Name" = "BU1_vpc001_SG01"
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
