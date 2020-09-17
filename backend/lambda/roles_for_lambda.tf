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