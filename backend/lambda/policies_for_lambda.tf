#Tuodaan s3_moduuli referoimista varten
module "s3_moduuli" {
  source = "../../frontend/s3/"
}

# Policy mahdollistaa GET-metodin S3 ämpäriin "customer_reviews_loppuprojekti_123",
# Amazon Comprehendin käytön sekä CloudWatch logien tekemisen
resource "aws_iam_policy" "lambda_analyze_with_comprehend" {
  name        = "lambda_analyze_with_comprehend_policy"
  description = "IAM policy with BasicLambdaExecution role and Amazon Comprehend full access"

  policy = data.aws_iam_policy_document.analyze_with_comprehend.json
}

#Policy document ylempää POST metodia varten:
data "aws_iam_policy_document" "analyze_with_comprehend" {
  statement {
    sid = "1as"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["${module.s3_moduuli.customer_reviews_s3_bucket_arn}/*","arn:aws:logs:*:*:*",
    ]
  }
  statement {
    sid = "2as"
    effect = "Allow"
    actions = [
      "comprehend:DetectSentiment"
    ]
    resources = ["*"]
  }
}