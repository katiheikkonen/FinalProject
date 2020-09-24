#Muutetaan lambdan suorittama .py tiedosto .zip muotoon ja archievetaan se:
data "archive_file" "put_to_analysis_s3" {
  type = "zip"
  source_file = "src/put_to_analysis_s3.py"
  output_path = "src/put_to_analysis_s3.zip"
}

#Lambda funktio:
resource "aws_lambda_function" "put_to_analysis_s3" {
  function_name = "put_to_analysis_s3"
  handler = "put_to_analysis_s3.put_to_analysis_s3"
  role = aws_iam_role.role_for_put_to_analysis_s3_lambda.arn
  runtime = "python3.7"
  filename = data.archive_file.put_to_analysis_s3.output_path
  source_code_hash = data.archive_file.put_to_analysis_s3.output_base64sha256
  tags = {
    Project = "Loppuprojekti"
  }
  tracing_config {
  mode = "Active"
  }
}

#Luodaan Lambdalle output arn
output "put_to_analysis_s3_arn" {
  value = aws_lambda_function.put_to_analysis_s3.arn
}

#  Luodaan DynamoDB streams yhteys DynamoDB taulun ja Lambdan välille
resource "aws_lambda_event_source_mapping" "event_source_mapping_dynamodb_lambda" {
  event_source_arn  = var.global_table_stream_arn
  function_name     = aws_lambda_function.put_to_analysis_s3.arn
  starting_position = "LATEST"
}