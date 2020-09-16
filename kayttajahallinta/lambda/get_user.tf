#archieve lambda:
data "archive_file" "hae_kayttaja" {
  type = "zip"
  source_file = "src/hae_kayttaja.py"
  output_path = "src/hae_kayttaja.zip"
}

#Lambda funktio:
resource "aws_lambda_function" "get_user" {
  function_name = "hae_kayttaja"
  handler = "hae_kayttaja.get_user"
  role = aws_iam_role.role_for_get_user_lambda.arn
  runtime = "python3.7"
  filename = data.archive_file.hae_kayttaja.output_path
  source_code_hash = data.archive_file.hae_kayttaja.output_base64sha256
}

output "get_user_lambda_arn" {
  value = aws_lambda_function.get_user.arn
}

output "get_user_lambda_name" {
  value = aws_lambda_function.get_user.function_name
}
output "get_user_lambda_invoke_arn" {
  value = aws_lambda_function.get_user.invoke_arn
}