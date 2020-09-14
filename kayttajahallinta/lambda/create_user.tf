#archieve lambda:
data "archive_file" "luo_kayttaja" {
  type = "zip"
  source_file = "src/luo_kayttaja.py"
  output_path = "src/luo_kayttaja.zip"
}

#Lambda funktio:
resource "aws_lambda_function" "create_user" {
  function_name = "luo_kayttaja"
  handler = "luo_kayttaja.create_user"
  role = aws_iam_role.role_for_create_user_lambda.arn
  runtime = "python3.7"
  filename = data.archive_file.luo_kayttaja.output_path
  source_code_hash = data.archive_file.luo_kayttaja.output_base64sha256
}

output "create_user_lambda_arn" {
  value = aws_lambda_function.create_user.arn
}

output "create_user_lambda_name" {
  value = aws_lambda_function.create_user.function_name
}