module "dummy_arn" {
  source = "../lambda2/"
}

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


resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.customer_reviews_s3.id

  lambda_function {
    lambda_function_arn = module.dummy_arn.lambda_dummy_arn
    events = ["s3:OdjectCreated:*"
    ]
    #filter_prefix       = "AWSLogs/"
    #filter_suffix       = ".log"
  }
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = module.dummy_arn.lambda_dummy_arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.customer_reviews_s3.arn
}