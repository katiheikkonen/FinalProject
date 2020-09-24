#Muutetaan lambdan suorittama .py tiedosto .zip muotoon ja archievetaan se:
data "archive_file" "testi_func" {
  type = "zip"
  source_file = "scr/func.py"

  output_path = "scr/func.zip"
}

#Lambda funktio:
resource "aws_lambda_function" "get_averages" {
  function_name = "get_averages_business_intelligence"
  handler = "func.get_sentiment"
  role = aws_iam_role.iam_get_sentiment_lambda.arn
  runtime = "python3.7"
  filename = data.archive_file.testi_func.output_path
  source_code_hash = "${data.archive_file.testi_func.output_base64sha256}-${aws_iam_role.iam_get_sentiment_lambda.arn}"
  environment {
    variables = {
      table = var.environmental_table_name
    }
  }
  tags = {
    Project = "Loppuprojekti"
  }
}