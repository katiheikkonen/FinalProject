module "roles" {
  source = "state_machine_and_lambdas\/roles_and_policies"
}

#Muutetaan lambdan suorittama .py tiedosto .zip muotoon ja archievetaan se:
data "archive_file" "post_to_dynamodb" {
  type = "zip"
  source_file = "src/post_to_dynamodb.py"
  output_path = "src/post_to_dynamodb.zip"
}

#Lambda funktio:
resource "aws_lambda_function" "post_to_dynamodb" {
  function_name = "post_dynamodb"
  handler = "post_to_dynamodb.post_to_dynamo"
  role = module.roles.anr_for_post_to_dynamo_role
  runtime = "python3.7"
  filename = data.archive_file.post_to_dynamodb.output_path
  source_code_hash = data.archive_file.post_to_dynamodb.output_base64sha256
  tags = {
    Project = "Loppuprojekti"
  }
  tracing_config {
  mode = "Active"
  }
}


#Luodaan Lambdalle output arn
output "dynamodb_arn" {
  value = aws_lambda_function.post_to_dynamodb.arn
}