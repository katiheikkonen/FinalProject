resource "aws_iam_policy" "lambda_get_from_s3_policy_test" {
  name        = "lambda_get_from_s3_policy_test"
  description = "IPSUS LAPSUS"
  path   = "/"
  policy = data.aws_iam_policy_document.lambda_get_from_s3_policy_document.json
}

#Policy document ylempää POST metodia varten:
data "aws_iam_policy_document" "lambda_get_from_s3_policy_document" {
  statement {
    sid = "blaablaablaaua"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["arn:aws:logs:*:*:*",
      "${aws_s3_bucket.customer_review_s3.arn}/*",
      aws_s3_bucket.customer_review_s3.arn
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