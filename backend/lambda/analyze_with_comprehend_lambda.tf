#Muutetaan lambdan suorittama .py tiedosto .zip muotoon ja archievetaan se:
data "archive_file" "analyze_with_comprehend" {
  type = "zip"
  source_file = "src/analyze_with_comprehend.py"
  output_path = "src/analyze_with_comprehend.zip"
}

#Lambda funktio:
resource "aws_lambda_function" "analyze_with_comprehend" {
  function_name = "analyze_with_comprehend"
  handler = "analyze_with_comprehend.sentimental_analysis"
  role = aws_iam_role.role_for_lambda_analyze_with_comprehend.arn
  runtime = "python3.7"
  filename = data.archive_file.analyze_with_comprehend.output_path
  source_code_hash = data.archive_file.analyze_with_comprehend.output_base64sha256
}

#Luodaan outputteja Lambdalle (arn ja name)
output "analyze_with_comprehend_arn" {
  value = aws_lambda_function.analyze_with_comprehend.arn
}

output "analyze_with_comprehend_name" {
  value = aws_lambda_function.analyze_with_comprehend.function_name
}