
resource "aws_s3_bucket" "customer_reviews_s3" {
  bucket = var.s3_bucket_name
  force_destroy = true
  tags = {
    Environment = "Dev"
    Owner = "Mikko"
  }
}

output "customer_reviews_s3_bucket_arn" {
  value = aws_s3_bucket.customer_reviews_s3.arn
}

output "customer_reviews_s3_bucket_id" {
  value = aws_s3_bucket.customer_reviews_s3.arn
}