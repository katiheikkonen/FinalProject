#Muutetaan lambdan suorittama .py tiedosto .zip muotoon ja archievetaan se:
data "archive_file" "get_from_s3" {
  type = "zip"
  source_file = "src/get_from_s3.py"
  output_path = "src/get_from_s3.zip"
}

#Lambda funktio:
resource "aws_lambda_function" "get_from_s3_lambda" {
  function_name = "get_from_s3_lambda"
  handler = "get_from_s3.get_object_from_s3"
  role = aws_iam_role.role_for_get_from_s3_lambda.arn
  runtime = "python3.7"
  filename = data.archive_file.get_from_s3.output_path
  source_code_hash = data.archive_file.get_from_s3.output_base64sha256
  tags = {
    Project = "Loppuprojekti"
  }
  tracing_config {
  mode = "Active"
  }
}

#Luodaan Lambdalle output arn
output "get_from_s3_arn" {
  value = aws_lambda_function.get_from_s3_lambda.arn
}