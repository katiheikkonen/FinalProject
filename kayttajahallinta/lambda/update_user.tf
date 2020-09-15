#archieve lambda:
data "archive_file" "paivita_kayttaja" {
  type = "zip"
  source_file = "src/paivita_kayttaja.py"
  output_path = "src/paivita_kayttaja.zip"
}

#Lambda funktio:
resource "aws_lambda_function" "update_user" {
  function_name = "paivita_kayttaja"
  handler = "paivita_kayttaja.update_user"
  role = aws_iam_role.role_for_update_user_lambda.arn
  runtime = "python3.7"
  filename = data.archive_file.paivita_kayttaja.output_path
  source_code_hash = data.archive_file.paivita_kayttaja.output_base64sha256
  depends_on = [aws_iam_role_policy_attachment.lambda_put1]
}

#Luodaan output arnille:
output "update_user_lambda_arn" {
  value = aws_lambda_function.create_user.arn
}

#Luodaan output lambdan nimelle:
output "update_user_lambda_name" {
  value = aws_lambda_function.create_user.function_name
}