#  LUODAAN API GATEWAYN ALLE TOTEUTUS LAMBDAN CREATE USER -TOIMINNOLLE

#  luodaan API Gatewaylle metodi POST
resource "aws_api_gateway_method" "create_user" {
  rest_api_id   = aws_api_gateway_rest_api.mystocksapi.id
  resource_id   = aws_api_gateway_resource.userdata.id
  http_method   = "POST"
  authorization = "NONE"
}

#  Luodaan API Gatewaylle deployment dev ympäristöön metodin kokeilua varten
resource "aws_api_gateway_deployment" "create_user" {
  depends_on = [aws_api_gateway_integration.create_user]
  rest_api_id = aws_api_gateway_rest_api.mystocksapi.id
  stage_name = "dev"
  #  Lifecycle policy create_before_destroy sisällytetty, koska auttaa järjestämään uudelleendeployausta
  lifecycle {
    create_before_destroy = true
  }
}

#  Integroidaan API Gateway create_user Lambda-funktion kanssa
resource "aws_api_gateway_integration" "create_user" {
  rest_api_id             = aws_api_gateway_rest_api.mystocksapi.id
  resource_id             = aws_api_gateway_resource.userdata.id
  http_method             = aws_api_gateway_method.create_user.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY" #  This type of integration lets an API method be integrated with the Lambda function invocation action
  uri                     = aws_lambda_function.create_user.invoke_arn #  API gateway invocation URI Lambda-funktiolle
}

#  Annetaan API Gatewaylle lupa create_user Lambdan käynnistämiseen
resource "aws_lambda_permission" "create_user" {
  statement_id = "AllowExecutionFromAPIGateway"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.create_user.function_name
  principal = "apigateway.amazonaws.com"

  source_arn = (aws_api_gateway_rest_api.mystocksapi.execution_arn) #"arn:aws:execute-api:eu-west-2:821383200340:tsefm0umhk/*/POST/userdata"
}