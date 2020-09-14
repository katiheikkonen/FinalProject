#  HUOM ei toimi vielä, Kati jatkaa tiistaina

resource "aws_api_gateway_resource" "create_user" {
  rest_api_id = aws_api_gateway_rest_api.mystocksapi.id
  parent_id   = aws_api_gateway_rest_api.mystocksapi.root_resource_id
  path_part   = "test" #  aws_lambda_function.createRaceResult.function_name
}

resource "aws_api_gateway_method" "create_user" {
  rest_api_id   = aws_api_gateway_rest_api.mystocksapi.id
  resource_id   = aws_api_gateway_resource.create_user.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "create_user" {
  rest_api_id             = aws_api_gateway_rest_api.mystocksapi.id
  resource_id             = aws_api_gateway_resource.create_user.id
  http_method             = aws_api_gateway_method.create_user.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = module.      #aws_lambda_function./l.invoke_arn
}

resource "aws_api_gateway_deployment" "create_user" {
  rest_api_id = "aws_api_gateway_rest_api.mystocksapi.id"
  stage_name  = "dev" #"var.stage_name"
  depends_on = [aws_api_gateway_method.create_user]
}

//#  Salli create_user Lambdan execution API Gatewaysta
//resource "aws_lambda_permission" "create_user" {
//  statement_id = "AllowExecutionFromAPIGateway"
//  action = "lambda:InvokeFunction"
//  function_name = aws_lambda_function.createRaceResult.function_name
//  principal = "apigateway.amazonaws.com"
//
//  source_arn = "aws_api_gateway_rest_api.mystocksapi.execution_arn/*/*/*"
//}