
resource "aws_iam_group_membership" "user-2-group" {
    users = var.users-list
    group = var.group_name

    name = "group-users"
  
}


