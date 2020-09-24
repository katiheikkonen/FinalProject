resource "aws_iam_policy" "lambda_archive_to_s3_policy" {
  name        = "lambda_archive_to_s3_policy"
  description = "IPSUS LAPSUS"
  path   = "/"
  policy = data.aws_iam_policy_document.lambda_archive_to_s3_policy_policy_document.json
}


data "aws_iam_policy_document" "lambda_archive_to_s3_policy_policy_document" {
  statement {
    sid = "blaa"
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["arn:aws:logs:*:*:*",
      "${aws_s3_bucket.archival_s3.arn}/*"
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