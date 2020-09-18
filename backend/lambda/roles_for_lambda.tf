
resource "aws_iam_role" "role_for_lambda_analyze_with_comprehend_plus" {
  name = "iam_for_analyze_with_comprehend_lambda_plus"
  #data.aws_iam_policy_document.analyze_with_comprehend.json
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": "1"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_analyze_with_comprehend_attachment" {
  role       = aws_iam_role.role_for_lambda_analyze_with_comprehend_plus.name
  policy_arn = aws_iam_policy.lambda_comprehend_s3_dynamo_logs.arn
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = module.s3_moduulit.customer_reviews_s3_bucket_id
  lambda_function {
    lambda_function_arn = aws_lambda_function.analyze_with_comprehend.arn
    events = ["s3:ObjectCreated:Put"]
  }
   depends_on = [aws_lambda_permission.allow_bucket]
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.analyze_with_comprehend.arn
  principal     = "s3.amazonaws.com"
  source_arn    = module.s3_moduulit.customer_reviews_s3_bucket_arn
}