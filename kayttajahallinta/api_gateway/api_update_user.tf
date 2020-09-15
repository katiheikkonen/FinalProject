#  LUODAAN API GATEWAYN ALLE TOTEUTUS LAMBDAN UPDATE USER -TOIMINNOLLE

//#  Luodaan mystocks APIlle resurssi update_user
//resource "aws_api_gateway_resource" "update_user" {
//  rest_api_id = aws_api_gateway_rest_api.mystocksapi.id
//  parent_id   = aws_api_gateway_rest_api.mystocksapi.root_resource_id #  API Gatewayn pääpolun määrittely
//  path_part   = "userdata" # API Gatewayn alapolku jonka alle metodi laitetaan, tässä tapauksessa DynamoDB:n taulun nimi
//}

#  luodaan API Gatewaylle metodi PUT
resource "aws_api_gateway_method" "update_user" {
  rest_api_id   = aws_api_gateway_rest_api.mystocksapi.id
  resource_id   = aws_api_gateway_resource.userdata_id.id
  http_method   = "PUT"
  authorization = "NONE"
}

#  Luodaan API Gatewaylle deployment dev ympäristöön metodin kokeilua varten
resource "aws_api_gateway_deployment" "update_user" {
  depends_on = [aws_api_gateway_integration.update_user]
  rest_api_id = aws_api_gateway_rest_api.mystocksapi.id
  stage_name = "dev"
  #  Lifecycle policy create_before_destroy sisällytetty, koska auttaa järjestämään uudelleendeployausta
  lifecycle {
    create_before_destroy = true
  }
}

#  Integroidaan API Gateway create_user Lambda-funktion kanssa
resource "aws_api_gateway_integration" "update_user" {
  rest_api_id             = aws_api_gateway_rest_api.mystocksapi.id
  resource_id             = aws_api_gateway_resource.userdata_id.id
  http_method             = aws_api_gateway_method.update_user.http_method
  integration_http_method = "PUT"
  type                    = "MOCK"#"AWS_PROXY" #  This type of integration lets an API method be integrated with the Lambda function invocation action
  #uri                     = module.lambda.create_user_lambda_invokearn #  API gateway invocation URI Lambda-funktiolle
}

#  Annetaan API Gatewaylle lupa create_user Lambdan käynnistämiseen
resource "aws_lambda_permission" "update_user" {
  statement_id = "AllowExecutionFromAPIGateway"
  action = "lambda:InvokeFunction"
  function_name = module.lambda.update_user_lambda_name
  principal = "apigateway.amazonaws.com"

  source_arn = aws_api_gateway_rest_api.mystocksapi.execution_arn
}