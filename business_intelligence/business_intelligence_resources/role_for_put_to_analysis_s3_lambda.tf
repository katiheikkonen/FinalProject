resource "aws_iam_role" "role_for_put_to_analysis_s3_lambda" {
  name = "iam_for_put_to_analysis_s3_lambda"
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

resource "aws_iam_role_policy_attachment" "lambda_put_to_analysis_s3_attachment" {
  role       = aws_iam_role.role_for_put_to_analysis_s3_lambda.name
  policy_arn = aws_iam_policy.lambda_put_to_analysis_s3_policy.arn
}