resource "aws_iam_user" "second_resource" {
  name = var.user_name

  tags = {
    tag-key = var.tag_key
  }
}