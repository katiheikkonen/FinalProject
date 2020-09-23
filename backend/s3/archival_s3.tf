#  S3 bucket for archival

resource "aws_s3_bucket" "archival_s3" {
  bucket = var.s3_bucket_name_archival
  force_destroy = true
  tags = {
    Environment = "Dev"
    Project = "Loppuprojekti"
  }
}

output "archival_s3_bucket_arn" {
  value = aws_s3_bucket.archival_s3.arn
}

output "archival_s3_bucket_id" {
  value = aws_s3_bucket.archival_s3.id
}