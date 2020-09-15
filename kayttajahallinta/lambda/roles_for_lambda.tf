#Rooli "create_user" lambdalle.-----------SPESIFOI MYÖHEMMIN TARKKA RESURSSI
resource "aws_iam_role" "role_for_create_user_lambda" {
  name = "iam_for_create_user_lambda"
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
      "Sid": "x"
    }
  ]
}
EOF
}

#Attachement for policy: role_for_create_user_lambda
resource "aws_iam_role_policy_attachment" "lambda_logs1" {
  role       = aws_iam_role.role_for_create_user_lambda.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}

#Attachement for policy: role_for_create_user_lambda
resource "aws_iam_role_policy_attachment" "lambda_post1" {
  role       = aws_iam_role.role_for_create_user_lambda.name
  policy_arn = aws_iam_policy.lambda_post_to_dynamo.arn
}