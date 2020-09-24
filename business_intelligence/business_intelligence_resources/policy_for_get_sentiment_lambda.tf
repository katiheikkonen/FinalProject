resource "aws_iam_policy" "lambda_get_sentiment_policy" {
  name        = "lambda_get_sentiment_policy"
  description = "IAM policy with BasicLambdaExecution role and Amazon Comprehend full access"
  path   = "/"
  policy = data.aws_iam_policy_document.get_sentiment_policy_doc.json
}

#Policy document ylempää GET metodia varten:
data "aws_iam_policy_document" "get_sentiment_policy_doc" {
  statement {
    sid = "iae"
    effect = "Allow"
    actions = [
      "dynamodb:GetItem",
      "dynamodb:Scan",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "*",
    ]
  }
}