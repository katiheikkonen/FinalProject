#Tuodaan s3_moduuli referoimista varten
module "s3_moduulit" {
  source = "s3"
}

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
      "${module.s3_moduulit.customer_reviews_s3_bucket_arn}/*",
      module.s3_moduulit.customer_reviews_s3_bucket_arn,
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