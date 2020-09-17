resource "aws_s3_bucket" "customer_reviews_s3" {
  bucket = var.s3_bucket_name
  force_destroy = true
  tags = {
    Environment = "Dev"
    Owner = "Mikko"
  }
}

output "customer_reviews_s3_bucket_arn" {
<<<<<<< HEAD:frontend/s3/static_website_s3.tf
  value = aws_s3_bucket.static_website_s3.arn
}

output "customer_reviews_s3_bucket_id" {
  value = aws_s3_bucket.static_website_s3.id
=======
  value = aws_s3_bucket.customer_reviews_s3.arn
>>>>>>> refs/remotes/origin/master:frontend/s3/customer_reviews_s3.tf
}