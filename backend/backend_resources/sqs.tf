#  Luodaan destination sentimental-analysis lambdalle

resource "aws_sqs_queue" "sentimental_analysis_lambda_failure_queue" {
  name                      = "sentimental-analysis-lambda-failure"
  message_retention_seconds = 1209600 #  viestiä säilytetään 14 päivää jonossa
  tags = {
    Owner = "Kati"
    Project = "Loppuprojekti"
  }
}

#  Luodaan Lambdalle output arn
output "sqs_failure_destination_arn" {
  value = aws_sqs_queue.sentimental_analysis_lambda_failure_queue.arn
}
