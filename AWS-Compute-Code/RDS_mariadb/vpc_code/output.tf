output "aws_vpc_id" {
  value = aws_vpc.dev_vpc.id
}


output "SG_dev_VPC" {
  value = [aws_security_group.Security001.id]
}

output "dev_public_subnet" {
  value = aws_subnet.pub-subnet.*.id
}

output "vpc_subnet001" { 
  value = element(aws_subnet.pub-subnet.*.id, 1)
  
}

output "vpc_subnet002" { 
  value = element(aws_subnet.pub-subnet.*.id, 2)
  
}

output "vpc_pvtsubnet001" {
  value = element(aws_subnet.pvt-sub001.*.id, 1)
}

output "vpc_pvtsubnet002" {
  value = element(aws_subnet.pvt-sub001.*.id, 2)
}