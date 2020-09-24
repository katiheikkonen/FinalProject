#Lambda rooli joka oikeuttaa policyn, jolla Lambda voi lähettää logitietoja ja julkaista SNS topikkiin:

resource "aws_iam_role" "role_for_send_to_sns_lambda" {
  name = "role_for_send_to_sns_lambda"
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

resource "aws_iam_role_policy_attachment" "lambda_send_to_sns_lambda_attachment" {
  role       = aws_iam_role.role_for_send_to_sns_lambda.name
  policy_arn = aws_iam_policy.lambda_send_to_sns_policy.arn
}

output "anr_for_send_to_sns_role" {
  value = aws_iam_role.role_for_send_to_sns_lambda.arn
}

output "name_for_send_to_sns_role" {
  value = aws_iam_role.role_for_send_to_sns_lambda.name
}