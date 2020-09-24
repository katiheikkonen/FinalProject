resource "aws_iam_policy" "lambda_put_to_analysis_s3_policy" {
  name        = "lambda_put_to_analysis_s3_policy"
  description = "IAM policy with permission to put object to S3, send logs to CloudWatch and info to X-Ray"
  path   = "/"
  policy = data.aws_iam_policy_document.lambda_put_to_analysis_s3_policy_document.json
}

#Policy document ylempää POST metodia varten:
data "aws_iam_policy_document" "lambda_put_to_analysis_s3_policy_document" {
  statement {
    sid = "analysiss3"
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "dynamodb:DescribeStream",
      "dynamodb:GetRecords",
      "dynamodb:GetShardIterator",
      "dynamodb:ListStreams"
    ]
    resources = [
      "${aws_s3_bucket.analysis_s3.arn}/*",
      "arn:aws:logs:*:*:*",
      var.global_table_stream_arn
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