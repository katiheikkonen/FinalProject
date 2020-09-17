#Rooli "post_to_s3" lambdalle, jotta Lambda voi kirjoittaa S3 buckettiin ja logata logeja CloudWatchiin:
resource "aws_iam_role" "role_for_post_to_s3_lambda" {
  name = "iam_for_post_to_s3_lambda"
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

#Liitetään POST_TO_S3 roolille policy, joka oikeuttaa PutItemin S3 ämpäriin:
resource "aws_iam_role_policy_attachment" "lambda_post_to_s3_attachment" {
  role       = aws_iam_role.role_for_post_to_s3_lambda.name
  policy_arn = aws_iam_policy.lambda_post_to_s3.arn
}

output "role_for_dummy" {
  value = aws_iam_role.role_for_post_to_s3_lambda.arn
}