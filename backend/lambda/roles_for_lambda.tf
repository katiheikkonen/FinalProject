#Rooli "post_to_s3" lambdalle, jotta Lambda voi kirjoittaa S3 buckettiin ja logata logeja CloudWatchiin:
resource "aws_iam_role" "role_for_lambda_analyze_with_comprehend" {
  name = "iam_for_analyze_with_comprehend_lambda"
  assume_role_policy = data.aws_iam_policy_document.analyze_with_comprehend.json
}

#Liitetään POST_TO_S3 roolille policy, joka oikeuttaa PutItemin S3 ämpäriin:
resource "aws_iam_role_policy_attachment" "lambda_analyze_with_comprehend_attachment" {
  role       = aws_iam_role.role_for_lambda_analyze_with_comprehend.name
  policy_arn = aws_iam_policy.lambda_analyze_with_comprehend.arn
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = module.s3_moduulit.customer_reviews_s3_bucket_id
  lambda_function {
    lambda_function_arn = aws_lambda_function.dummy_lambda_func.arn
    events = ["s3:ObjectCreated:*"
    ]
    #filter_prefix       = "AWSLogs/"
    #filter_suffix       = ".log"
  }
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.dummy_lambda_func.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = module.s3_moduulit.customer_reviews_s3_bucket_arn
}