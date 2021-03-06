resource "aws_iam_policy" "lambda_post_to_dynamodb_policy_test" {
  name        = "lambda_post_to_dynamodb_policy_test_ver2"
  description = "IPSUS LAPSUS"
  path   = "/"
  policy = data.aws_iam_policy_document.lambda_post_to_dynamodb_document.json
}

#Policy document ylempää metodia varten:
data "aws_iam_policy_document" "lambda_post_to_dynamodb_document" {
  statement {
    sid = "jaadajaadajaaa"
    effect = "Allow"
    actions = [
      "dynamodb:PutItem",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [aws_dynamodb_table.eu-central-1.arn,
      "arn:aws:logs:*:*:*"
    ]
  }
  statement {
  sid = "adfteaetesd"
  effect = "Allow"
  actions = ["xray:PutTraceSegments",
    "xray:PutTelemetryRecords",
    "xray:GetSamplingRules",
    "xray:GetSamplingTargets",
    "xray:GetSamplingStatisticSummaries"
  ]
  resources = ["*",
    ]
}
}