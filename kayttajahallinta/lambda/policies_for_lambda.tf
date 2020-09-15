#"lambda_logging" mahdollistaa
resource "aws_iam_policy" "lambda_logging" {
  name        = "lambda_logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}


#"lambda_put_to_dynamo" mahdollistaa POST metodin DynamoDB tauluun XXXX
resource "aws_iam_policy" "lambda_post_to_dynamo" {
  name        = "lambda_post_to_dynamo"
  description = "IAM policy for WRITE PutItem from a lambda to DynamoDB table XXX"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action":"dynamodb:PutItem",
      "Resource": "*",
      "Effect": "Allow"
    }
  ]
}
EOF
}