#  LUODAAN API GATEWAYN ALLE TOTEUTUS LAMBDAN DELETE USER -TOIMINNOLLE

//#  Luodaan mystocks APIlle resurssi delete_user
//resource "aws_api_gateway_resource" "delete_user" {
//  rest_api_id = aws_api_gateway_rest_api.mystocksapi.id
//  parent_id   = aws_api_gateway_rest_api.mystocksapi.root_resource_id #  API Gatewayn pääpolun määrittely
//  path_part   = "userdata" # API Gatewayn alapolku jonka alle metodi laitetaan, tässä tapauksessa DynamoDB:n taulun nimi
//}

#  luodaan API Gatewaylle metodi DELETE
resource "aws_api_gateway_method" "delete_user" {
  rest_api_id   = aws_api_gateway_rest_api.mystocksapi.id
  resource_id   = aws_api_gateway_resource.userdata_id.id
  http_method   = "DELETE"
  authorization = "NONE"
}

#  Luodaan API Gatewaylle deployment dev ympäristöön metodin kokeilua varten
resource "aws_api_gateway_deployment" "delete_user" {
  depends_on = [aws_api_gateway_integration.delete_user]
  rest_api_id = aws_api_gateway_rest_api.mystocksapi.id
  stage_name = "dev"
  #  Lifecycle policy create_before_destroy sisällytetty, koska auttaa järjestämään uudelleendeployausta
  lifecycle {
    create_before_destroy = true
  }
}

#  Integroidaan API Gateway delete_user Lambda-funktion kanssa
resource "aws_api_gateway_integration" "delete_user" {
  rest_api_id             = aws_api_gateway_rest_api.mystocksapi.id
  resource_id             = aws_api_gateway_resource.userdata_id.id
  http_method             = aws_api_gateway_method.delete_user.http_method
  integration_http_method = "DELETE"
  type                    = "MOCK"#"AWS_PROXY" #  This type of integration lets an API method be integrated with the Lambda function invocation action
  #uri                     = module.lambda.delete_user_lambda_invoke_arn #  API gateway invocation URI Lambda-funktiolle
}

#  Annetaan API Gatewaylle lupa delete_user Lambdan käynnistämiseen
resource "aws_lambda_permission" "delete_user" {
  statement_id = "AllowExecutionFromAPIGateway"
  action = "lambda:InvokeFunction"
  function_name = module.lambda_outputs.delete_user_lambda_name
  principal = "apigateway.amazonaws.com"

  source_arn = aws_api_gateway_rest_api.mystocksapi.execution_arn
}