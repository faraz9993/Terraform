resource "aws_s3_bucket" "first_resource" {
  bucket = var.bucket

  tags = {
    Name        = var.tag
  }
}