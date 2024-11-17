output "ITOC_users" {
    value = aws_iam_user.monitor-user.*.name
}

output "ITOC_group" {
    value = aws_iam_group.ITOC_groups.name
  
}