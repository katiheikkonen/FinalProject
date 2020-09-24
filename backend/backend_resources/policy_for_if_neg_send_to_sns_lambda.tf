module "customer_service_sns" {
  source = "../../sns/"
}

#Policy joka oikeuttaa lambdaa lähettämään SNS topikkiin viestiä
resource "aws_iam_policy" "lambda_send_to_sns_policy" {
  name        = "lambda_send_to_sns_policy"
  description = "IPSUS LAPSUS"
  path   = "/"
  policy = data.aws_iam_policy_document.lambda_send_to_sns_document.json
}

#Policy document ylempää POST metodia varten:
data "aws_iam_policy_document" "lambda_send_to_sns_document" {
  statement {
    sid = "LogAndSendToSns"
    effect = "Allow"
    actions = [
      "sns:Publish",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["arn:aws:logs:*:*:*",
      aws_sns_topic.customer_service_negative_review.arn
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