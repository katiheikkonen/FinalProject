
resource "aws_s3_bucket" "customer_review_s3" {
  bucket = var.s3_bucket_name_customer_review
  force_destroy = true
  tags = {
    Environment = "Dev"
    Project = "Loppuprojekti"
  }
}

output "customer_reviews_s3_bucket_arn" {
  value = aws_s3_bucket.customer_review_s3.arn
}

output "customer_reviews_s3_bucket_id" {
  value = aws_s3_bucket.customer_review_s3.id
}