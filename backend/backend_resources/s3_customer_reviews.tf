
resource "aws_s3_bucket" "customer_review_s3" {
  bucket = var.s3_bucket_name_customer_review
  force_destroy = true
  tags = {
    Environment = "Dev"
    Project = "Loppuprojekti"
  }
}

#  Luodaan bucket notification, jotta invoke_stepfuntion lambda käynnistyy kun bucketiin laitetaan uusi arvostelu
resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.customer_review_s3.id
  lambda_function {
    lambda_function_arn = aws_lambda_function.invoke_stepfunction.arn
    events = ["s3:ObjectCreated:Put"]
  }
   depends_on = [aws_lambda_permission.allow_bucket]
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.invoke_stepfunction.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.customer_review_s3.arn
}

output "customer_reviews_s3_bucket_arn" {
  value = aws_s3_bucket.customer_review_s3.arn
}

output "customer_reviews_s3_bucket_id" {
  value = aws_s3_bucket.customer_review_s3.id
}