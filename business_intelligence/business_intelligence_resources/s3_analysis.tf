#  S3 bucket tiedostojen analysointia varten

resource "aws_s3_bucket" "analysis_s3" {
  bucket = "analysis-loppuprojekti"
  force_destroy = true
  tags = {
    Environment = "Dev"
    Project = "Loppuprojekti"
  }
}

output "archival_s3_bucket_arn" {
  value = aws_s3_bucket.analysis_s3.arn
}

output "archival_s3_bucket_id" {
  value = aws_s3_bucket.analysis_s3.id
}