#Tuodaan moduulilla sns ARN
module "customer_service_sns" {
  source = "../../sns/"
}

#Muutetaan lambdan suorittama .py tiedosto .zip muotoon ja archievetaan se:
data "archive_file" "if_negative_then_sns" {
  type = "zip"
  source_file = "src/if_negative_then_sns.py"
  output_path = "src/if_negative_then_sns.zip"
}

#Lambda funktio:
resource "aws_lambda_function" "if_negative_then_sns_lambda" {
  function_name = "if_negative_then_sns"
  handler = "if_negative_then_sns.check_negativity"
  role = module.roles.anr_for_send_to_sns_role
  runtime = "python3.7"
  filename = data.archive_file.if_negative_then_sns.output_path
  source_code_hash = "${data.archive_file.if_negative_then_sns.output_base64sha256}-${module.roles.name_for_send_to_sns_role}"
  tags = {
    Project = "Loppuprojekti"
  }
  environment {
    variables = {
      sns_topic = module.customer_service_sns.customer_service_sns_arn
    }
  }
}

#Luodaan Lambdalle output arn
output "if_neg_then_sns_arn" {
  value = aws_lambda_function.if_negative_then_sns_lambda.arn
}