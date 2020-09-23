#Muutetaan lambdan suorittama .py tiedosto .zip muotoon ja archievetaan se:
data "archive_file" "comprehend" {
  type = "zip"
  source_file = "../src/comprehend.py"
  output_path = "../src/comprehend.zip"
}

#Lambda funktio:
resource "aws_lambda_function" "comprehend_lambda" {
  function_name = "comprehend_lambda"
  handler = "comprehend.sentimental_analysis"
  role = module.roles.anr_for_post_to_comprehend_role
  runtime = "python3.7"
  filename = data.archive_file.comprehend.output_path
  source_code_hash = data.archive_file.comprehend.output_base64sha256
  tags = {
    Project = "Loppuprojekti"
  }
}


#Luodaan Lambdalle output arn
output "comprehend_arn" {
  value = aws_lambda_function.comprehend_lambda.arn
}