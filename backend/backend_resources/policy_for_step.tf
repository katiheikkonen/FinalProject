#  Luodaan State Machinelle policy ja policy document, jotka oikeuttavat tarvittavien Lambdojen ajamiseen

resource "aws_iam_policy" "state_machine_iam_policy_ver2" {
  name        = "state_machine_for_loppuprojekti_policy_ver2"
  description = "IAM policy with State machine access to the required Lambda Functions"
  path   = "/"
  policy = data.aws_iam_policy_document.state_machine_policy_document.json
}

data "aws_iam_policy_document" "state_machine_policy_document" {
  statement {
    sid = "statemachinepolicyVer2"
    effect = "Allow"
    actions = [
      "lambda:InvokeFunction"
    ]
    resources = [
      module.lambda_functions.comprehend_arn,
      module.lambda_functions.dynamodb_arn,
      module.lambda_functions.get_from_s3_arn,
      module.lambda_functions.post_to_s3_archive_arn,
      module.lambda_functions.if_neg_then_sns_arn,
    ]
  }
}