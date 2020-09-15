#  HUOM ei toimi vielä, Kati jatkaa tiistaina

#  Tuodaan lambda-moduuli
module "lambda" {
source  = "../lambda"
}

#  Luodaan mystocks APIlle resurssi create_user
resource "aws_api_gateway_resource" "create_user" {
  rest_api_id = aws_api_gateway_rest_api.mystocksapi.id
  parent_id   = aws_api_gateway_rest_api.mystocksapi.root_resource_id
  path_part   = module.lambda.create_user_lambda_name #  mieti vielä miten tätä tarvitaan
}

#  luodaan API Gatewaylle metodi POST
resource "aws_api_gateway_method" "create_user" {
  rest_api_id   = aws_api_gateway_rest_api.mystocksapi.id
  resource_id   = aws_api_gateway_resource.create_user.id
  http_method   = "POST"
  authorization = "NONE"
}

#  Luodaan API Gatewaylle deployment dev ympäristöön metodin kokeilua varten
resource "aws_api_gateway_deployment" "create_user" {
  depends_on = [
    aws_api_gateway_integration.create_user]
  rest_api_id = aws_api_gateway_rest_api.mystocksapi.id
  stage_name = "dev"
  #"var.stage_name"
  #  Lifecycle policy create_before_destroy sisällytetty, koska auttaa järjestämään uudelleendeployausta
  lifecycle {
    create_before_destroy = true
  }
}

#  Integroidaan API Gateway create_user Lambda-funktion kanssa
resource "aws_api_gateway_integration" "create_user" {
  rest_api_id             = aws_api_gateway_rest_api.mystocksapi.id
  resource_id             = aws_api_gateway_resource.create_user.id
  http_method             = aws_api_gateway_method.create_user.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = module.lambda.create_user_lambda_invokearn #  API gateway invocation URI Lambda-funktiolle
}

#  Annetaan API Gatewaylle lupa create_user Lambdan käynnistämiseen
resource "aws_lambda_permission" "create_user" {
  statement_id = "AllowExecutionFromAPIGateway"
  action = "lambda:InvokeFunction"
  function_name = module.lambda.create_user_lambda_name
  principal = "apigateway.amazonaws.com"

  source_arn = aws_api_gateway_rest_api.mystocksapi.arn
}