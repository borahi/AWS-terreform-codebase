output "aws_instance1" {
    value = element (aws_instance.my-test-machine.*.id, 1)
  
}

output "aws_instance2" {
    value = element (aws_instance.my-test-machine.*.id, 2)
  
}