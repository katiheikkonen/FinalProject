resource "aws_iam_policy" "lambda_post_to_comprehend_policy_test" {
  name        = "lambda_post_to_comprehend_policy_test_ver2"
  description = "IPSUS LAPSUS"
  path   = "/"
  policy = data.aws_iam_policy_document.lambda_post_to_comprehend_document.json
}

#Policy document ylempää POST metodia varten:
data "aws_iam_policy_document" "lambda_post_to_comprehend_document" {
  statement {
    sid = "blaablaablaaa"
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["arn:aws:logs:*:*:*"
    ]
  }
  statement {
    sid = "jaadadiiduladuuu"
    effect = "Allow"
    actions = ["comprehend:DetectSentiment"
    ]
    resources = ["*",
      ]
  }
}