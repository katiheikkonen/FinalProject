#Muutetaan lambdan suorittama .py tiedosto .zip muotoon ja archievetaan se:
data "archive_file" "dummy_lambda" {
  type = "zip"
  source_file = "src/dummy_lambda.py"
  output_path = "src/dummy_lambda.zip"
}

module "role" {
  source = "../../frontend/api_gateway and lambda/"
}


#Lambda funktio:
resource "aws_lambda_function" "dummy_lambda_func" {
  function_name = "dummy_lambda"
  handler = "dummy_lambda.dummy"
  role = module.role.role_for_dummy
  runtime = "python3.7"
  filename = data.archive_file.dummy_lambda.output_path
  source_code_hash = data.archive_file.dummy_lambda.output_base64sha256
}


resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.dummy_lambda_func.arn
  principal     = "s3.amazonaws.com"
  source_arn    = module.s3_moduuli.customer_reviews_s3_bucket_arn
}


resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = module.s3_moduuli.customer_reviews_s3_bucket_id

  lambda_function {
    lambda_function_arn = aws_lambda_function.dummy_lambda_func.arn
    events = [
      "s3:ObjectCreated:*"]
    #filter_prefix       = "AWSLogs/"
    #filter_suffix       = ".log"
  }
}