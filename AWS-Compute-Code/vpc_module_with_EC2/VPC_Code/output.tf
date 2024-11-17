output "aws_vpc_id" {
  value = aws_vpc.dev_vpc.id
}


output "SG_dev_VPC" {
  value = [aws_security_group.Security001.id]
}

output "dev_public_subnet" {
  value = aws_subnet.pub-subnet.*.id
}