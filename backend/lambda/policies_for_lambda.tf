#Tuodaan s3_moduuli referoimista varten
module "s3_moduulit" {
  source = "../s3/"
}

resource "aws_iam_policy" "s3_get_and_cw_log" {
  name        = "lambda_analyze_with_comprehend_policy"
  description = "IAM policy with BasicLambdaExecution role and Amazon Comprehend full access"

  policy = data.aws_iam_policy_document.s3_get_and_cw_log.json
}

#Policy document ylempää POST metodia varten:
data "aws_iam_policy_document" "s3_get_and_cw_log" {
  statement {
    sid = "1as"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "dynamodb:PutItem",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "${module.s3_moduulit.customer_reviews_s3_bucket_arn}/*",
      "arn:aws:logs:*:*:*",
    ]
  }
}

resource "aws_iam_policy" "lambda_analyze_with_comprehend" {
  name        = "lambda_analyze_with_comprehend_policy"
  description = "IAM policy with BasicLambdaExecution role and Amazon Comprehend full access"

  policy = data.aws_iam_policy_document.analyze_with_comprehend.json
}

data "aws_iam_policy_document" "analyze_with_comprehend" {
  statement {
    sid = "2as"
    effect = "Allow"
    actions = [
      "comprehend:DetectSentiment"
    ]
    resources = ["*"]
  }
}