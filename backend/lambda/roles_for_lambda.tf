
resource "aws_iam_role" "role_for_lambda_analyze_with_comprehend" {
  name = "iam_for_analyze_with_comprehend_lambda"
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
  role       = aws_iam_role.role_for_lambda_analyze_with_comprehend.name
  policy_arn = aws_iam_policy.lambda_analyze_with_comprehend.arn
}

resource "aws_iam_role_policy_attachment" "s3_get_and_cw_log_attachment" {
  role       = aws_iam_role.role_for_lambda_analyze_with_comprehend.name
  policy_arn = aws_iam_policy.s3_get_and_cw_log.arn
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = module.s3_moduulit.customer_reviews_s3_bucket_id
  lambda_function {
    lambda_function_arn = aws_lambda_function.dummy_lambda_func.arn
    events = ["s3:POST"]
    #filter_prefix       = "AWSLogs/"
    #filter_suffix       = ".log"
  }
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.dummy_lambda_func.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = module.s3_moduulit.customer_reviews_s3_bucket_arn
}