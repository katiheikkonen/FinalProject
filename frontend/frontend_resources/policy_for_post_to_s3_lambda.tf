#"lambda_post_to_s3" mahdollistaa POST metodin S3 ämpäriin "customer_reviews_loppuprojekti_123" ja oikeuttaa CloudWatch logien tekemisen:
resource "aws_iam_policy" "lambda_post_to_s3" {
  name        = "lambda_post_to_s3_policy"
  path = "/"
  description = "IAM policy for WRITE PostItem from a lambda to S3 'customer_reviews_.."

  policy = data.aws_iam_policy_document.post_to_s3.json
}

#Policy document ylempää POST metodia varten:
data "aws_iam_policy_document" "post_to_s3" {
  statement {
    sid = "123"
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["arn:aws:logs:*:*:*", "${var.bucket_arn}/*",
    ]
  }
}