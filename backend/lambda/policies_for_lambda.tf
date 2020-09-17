#Tuodaan s3_moduuli referoimista varten
module "s3_moduulit" {
  source = "../s3/"
}

resource "aws_iam_policy" "lambda_analyze_with_comprehend" {
  name        = "lambda_analyze_with_comprehend_policy"
  description = "IAM policy with BasicLambdaExecution role and Amazon Comprehend full access"

  policy = data.aws_iam_policy_document.analyze_with_comprehend.json
}

#Policy document ylempää POST metodia varten:
data "aws_iam_policy_document" "analyze_with_comprehend" {
  statement {
    sid = "1as"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "dynamodb:PutItem",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "comprehend:DetectSentiment"
    ]
    resources = [
      "${module.s3_moduulit.customer_reviews_s3_bucket_arn}/*",
      "arn:aws:logs:*:*:*",
      "*"
    ]
  }
}