
resource "aws_iam_role" "role_for_post_to_dynamodb_lambda" {
  name = "iam_for_post_to_dynamodb_lambda_ver2"
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

resource "aws_iam_role_policy_attachment" "lambda_post_to_dynamo_attachment" {
  role       = aws_iam_role.role_for_post_to_dynamodb_lambda.name
  policy_arn = aws_iam_policy.lambda_post_to_dynamodb_policy_test.arn
}

output "anr_for_post_to_dynamo_role" {
  value = aws_iam_role.role_for_post_to_dynamodb_lambda.arn
}