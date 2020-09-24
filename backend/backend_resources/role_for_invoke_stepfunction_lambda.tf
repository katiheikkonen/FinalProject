
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

