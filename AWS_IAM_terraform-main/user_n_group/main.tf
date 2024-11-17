resource "aws_iam_group" "ITOC_groups" {
    name = "ITOC-Group-restrict"
    
}

resource "aws_iam_user" "monitor-user" {
    count = 10
    name = "ITOCuser00${count.index + 1}"
    
  
}


resource "aws_iam_policy" "ITOC-policy" {
    name = "ITOC-Team"
    policy = file("${path.module}/policy.json")

}

resource "aws_iam_group_policy_attachment" "attach-2-group" {
    policy_arn = aws_iam_policy.ITOC-policy.arn
    group = aws_iam_group.ITOC_groups.name
    
    
    depends_on = [
    aws_iam_group.ITOC_groups

  ]
}
