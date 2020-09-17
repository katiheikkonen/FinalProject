#Tuodaan s3_moduuli referoimista varten
module "s3_moduulit" {
  source = "../s3/"
}
module "dynamodb_arn" {
  source = "../dynamodb/"
}

resource "aws_iam_policy" "lambda_comprehend_s3_dynamo_logs" {
  name        = "lambda_analyze_with_comprehend_policy_plus"
  description = "IAM policy with BasicLambdaExecution role and Amazon Comprehend full access"
  path   = "/"
  policy = data.aws_iam_policy_document.analyze_getitem_putitem_logs.json
}

#Policy document ylempää POST metodia varten:
data "aws_iam_policy_document" "analyze_getitem_putitem_logs" {
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
      "${module.dynamodb_arn.dynamo_table_sentiment_analysis_data_arn}/*",
      "arn:aws:logs:*:*:*",
    ]
  }
  statement {
    sid = "1as"
    effect = "Allow"
    actions = ["comprehend:DetectSentiment"
    ]
    resources = ["*",
      ]
  }
}