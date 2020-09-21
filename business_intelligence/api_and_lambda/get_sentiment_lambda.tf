#Muutetaan lambdan suorittama .py tiedosto .zip muotoon ja archievetaan se:
module "lambda_rooli" {
  source = "../roles_and_policies/"
}

data "archive_file" "testi_func" {
  type = "zip"
  source_file = "scr/func.py"

  output_path = "scr/func.zip"
}

#Lambda funktio:
resource "aws_lambda_function" "get_averages" {
  function_name = "get_averages_business_intelligence"
  handler = "func.get_sentiment"
  role = module.lambda_rooli.lambda_role_arn
  runtime = "python3.7"
  filename = data.archive_file.testi_func.output_path
  source_code_hash = "${data.archive_file.testi_func.output_base64sha256}-${module.lambda_rooli.lambda_role_name}"
  environment {
    variables = {
      table = var.environmental_table_name
    }
  }
  tags = {
    Project = "Loppuprojekti"
  }
}