#Muutetaan lambdan suorittama .py tiedosto .zip muotoon ja archievetaan se:
data "archive_file" "post_to_s3" {
  type = "zip"
  source_file = "src/post_to_s3.py"
  output_path = "src/post_to_s3.zip"
}

#Lambda funktio:
resource "aws_lambda_function" "post_to_s3" {
  function_name = "post_to_s3"
  handler = "post_to_s3.from_api_to_s3"
  role = aws_iam_role.role_for_post_to_s3_lambda.arn
  runtime = "python3.7"
  filename = data.archive_file.post_to_s3.output_path
  source_code_hash = data.archive_file.post_to_s3.output_base64sha256
}

#Luodaan outputteja Lambdalle (arn, name ja invoke_arn)
output "create_user_lambda_arn" {
  value = aws_lambda_function.post_to_s3.arn
}

output "create_user_lambda_name" {
  value = aws_lambda_function.post_to_s3.function_name
}

output "create_user_lambda_invoke_arn" {
  value = aws_lambda_function.post_to_s3.invoke_arn
}