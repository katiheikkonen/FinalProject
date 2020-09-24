
resource "aws_iam_role" "role_for_invoke_stepfunction_lambda" {
  name = "iam_for_invoke_stepfunction_lambda_ver2"
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

resource "aws_iam_role_policy_attachment" "lambda_invoke_step_function_attachment" {
  role       = aws_iam_role.role_for_invoke_stepfunction_lambda.name
  policy_arn = aws_iam_policy.lambda_invoke_stepfunction_policy.arn
}

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