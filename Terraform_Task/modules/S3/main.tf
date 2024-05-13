resource "aws_s3_bucket" "first_resource" {
  bucket = var.bucket_name

  tags = {
    Name        = "first"
  }
}