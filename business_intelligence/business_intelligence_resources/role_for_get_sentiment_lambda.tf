resource "aws_iam_role" "iam_get_sentiment_lambda" {
  name = "iam_get_sentiment_lambda"
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

#Yhdistetään resurssi ja rooli toisiinsa
resource "aws_iam_role_policy_attachment" "lambda_analyze_with_comprehend_attachment" {
  role       = aws_iam_role.iam_get_sentiment_lambda.name
  policy_arn = aws_iam_policy.lambda_get_sentiment_policy.arn
}

output "lambda_role_arn" {
  value = aws_iam_role.iam_get_sentiment_lambda.arn
}

output "lambda_role_name" {
  value = aws_iam_role.iam_get_sentiment_lambda.name
}