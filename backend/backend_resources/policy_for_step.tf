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
      aws_lambda_function.comprehend_lambda.arn,
      aws_lambda_function.post_to_dynamodb.arn,
      aws_lambda_function.get_from_s3_lambda.arn,
      aws_lambda_function.post_to_s3_archive_lambda.arn,
      aws_lambda_function.if_negative_then_sns_lambda.arn
    ]
  }
}