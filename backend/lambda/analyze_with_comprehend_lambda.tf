#Muutetaan lambdan suorittama .py tiedosto .zip muotoon ja archievetaan se:
data "archive_file" "sentimental_analysis" {
  type = "zip"
  source_file = "src/sentimental_analysis.py"
  output_path = "src/sentimental_analysis.zip"
}

#Lambda funktio:
resource "aws_lambda_function" "analyze_with_comprehend" {
  function_name = "sentimental_analysis"
  handler = "analyze_with_comprehend.lambda_handler" # nämä vielä vaihtoon
  role = aws_iam_role.role_for_post_to_s3_lambda.arn
  runtime = "python3.7"
  filename = data.archive_file.post_to_s3.output_path
  source_code_hash = data.archive_file.post_to_s3.output_base64sha256
}

#Luodaan outputteja Lambdalle (arn, name ja invoke_arn)
output "post_to_s3_lambda_arn" {
  value = aws_lambda_function.post_to_s3.arn
}

output "post_to_s3_lambda_name" {
  value = aws_lambda_function.post_to_s3.function_name
}

output "post_to_s3_lambda_invoke_arn" {
  value = aws_lambda_function.post_to_s3.invoke_arn
}