

resource "aws_iam_policy" "lambda_invoke_stepfunction_policy" {
  name        = "lambda_invoke_stepfunction_policy_ver2"
  description = "IAM policy with permission to invoke StepFunction state machine and send logs to CloudWatch"
  path   = "/"
  policy = data.aws_iam_policy_document.lambda_invoke_stepfunction_policy_document.json
}

#Policy document ylempää POST metodia varten:
data "aws_iam_policy_document" "lambda_invoke_stepfunction_policy_document" {
  statement {
    sid = "invokestepfunction"
    effect = "Allow"
    actions = [
      "states:StartExecution",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = [
      aws_sfn_state_machine.sentimental_analysis_state_machine.arn,
      "arn:aws:logs:*:*:*",
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