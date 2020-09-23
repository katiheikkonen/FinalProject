#Muutetaan lambdan suorittama .py tiedosto .zip muotoon ja archievetaan se:
data "archive_file" "post_to_s3_archive" {
  type = "zip"
  source_file = "../src/post_to_s3_archive.py"
  output_path = "../src/post_to_s3_archive.zip"
}

#Lambda funktio:
resource "aws_lambda_function" "post_to_s3_archive_lambda" {
  function_name = "post_to_s3_archive"
  handler = "post_to_s3_archive.archive_to_s3_bucket"
  role = module.roles.anr_for_archive_to_s3_role
  runtime = "python3.7"
  filename = data.archive_file.post_to_s3_archive.output_path
  source_code_hash = data.archive_file.post_to_s3_archive.output_base64sha256
  tags = {
    Project = "Loppuprojekti"
  }
}

#Luodaan Lambdalle output arn
output "post_to_s3_archive_arn" {
  value = aws_lambda_function.post_to_s3_archive_lambda.arn
}