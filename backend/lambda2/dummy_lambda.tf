#Muutetaan lambdan suorittama .py tiedosto .zip muotoon ja archievetaan se:
data "archive_file" "dummy_lambda" {
  type = "zip"
  source_file = "src/dummy_lambda.py"
  output_path = "src/dummy_lambda.zip"
}

#Lambda funktio:
resource "aws_lambda_function" "dummy_lambda_func" {
  function_name = "dummy_lambda"
  handler = "dummy_lambda.dummy"
  role = "arn:aws:iam::821383200340:role/mervi-allow-s3-for-lambda-role"
  runtime = "python3.7"
  filename = data.archive_file.dummy_lambda.output_path
  source_code_hash = data.archive_file.dummy_lambda.output_base64sha256
}

output "lambda_dummy_arn" {
  value = aws_lambda_function.dummy_lambda_func.arn
}