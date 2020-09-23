#Muutetaan lambdan suorittama .py tiedosto .zip muotoon ja archievetaan se:
data "archive_file" "invoke_stepfunction" {
  type = "zip"
  source_file = "src/invoke_stepfunction.py"
  output_path = "src/invoke_stepfunction.zip"
}

#Lambda funktio:
resource "aws_lambda_function" "invoke_stepfunction" {
  function_name = "invoke_stepfunction"
  handler = "invoke_stepfunction.invoke_stepfunction"
  role = aws_iam_role.role_for_invoke_stepfunction_lambda.arn  #  VAIHDA VIELÄ
  runtime = "python3.7"
  filename = data.archive_file.invoke_stepfunction.output_path
  source_code_hash = data.archive_file.invoke_stepfunction.output_base64sha256
  tags = {
    Project = "Loppuprojekti"
  }
}

#Luodaan Lambdalle output arn
output "invoke_stepfucntion_arn" {
  value = aws_lambda_function.invoke_stepfunction.arn
}