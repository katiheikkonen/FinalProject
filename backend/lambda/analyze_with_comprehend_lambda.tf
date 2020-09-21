#  Tuodaan SQS-jonon arn destination referoimista varten
module "sqs_arn" {
  source = "../sqs/"
}

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
  role = aws_iam_role.role_for_lambda_analyze_with_comprehend_plus.arn
  runtime = "python3.7"
  filename = data.archive_file.analyze_with_comprehend.output_path
  source_code_hash = data.archive_file.analyze_with_comprehend.output_base64sha256
  tags = {
    Project = "Loppuprojekti"
  }
}

#  Luodaan Lambdalle Destination SQS-queue, jonne menee tieto silloin kun lambdan suoritus epäonnistuu
resource "aws_lambda_function_event_invoke_config" "lambda_destination_failure" {
  function_name = aws_lambda_function.analyze_with_comprehend.function_name

  destination_config {
    on_failure {
      destination = module.sqs_arn.sqs_failure_destination_arn
    }
  }
}

#Luodaan Lambdalle output arn
output "analyze_with_comprehend_arn" {
  value = aws_lambda_function.analyze_with_comprehend.arn
}