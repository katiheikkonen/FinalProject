#archieve lambda:
data "archive_file" "poista_kayttaja" {
  type = "zip"
  source_file = "src/poista_kayttaja.py"
  output_path = "src/poista_kayttaja.zip"
}

#Lambda funktio:
resource "aws_lambda_function" "delete_user" {
  function_name = "poista_kayttaja"
  handler = "poista_kayttaja.delete_user"
  role = aws_iam_role.role_for_delete_user_lambda.arn
  runtime = "python3.7"
  filename = data.archive_file.poista_kayttaja.output_path
  source_code_hash = data.archive_file.poista_kayttaja.output_base64sha256
}

output "delete_user_lambda_arn" {
  value = aws_lambda_function.delete_user.arn
}

output "delete_user_lambda_name" {
  value = aws_lambda_function.delete_user.function_name
}