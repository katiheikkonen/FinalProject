
#  Luodaan sovelluksen APIlle polku get_sentiment
resource "aws_api_gateway_resource" "get_sentiment" {
  rest_api_id = aws_api_gateway_rest_api.GetSentimentAPI.id
  parent_id   = aws_api_gateway_rest_api.GetSentimentAPI.root_resource_id #  API Gatewayn pääpolun määrittely
  path_part   = "get_sentiment"
}

#  luodaan API Gatewaylle metodi GET asiakaspalautteen lähettämiseen
resource "aws_api_gateway_method" "send_review" {
  rest_api_id   = aws_api_gateway_rest_api.GetSentimentAPI.id
  resource_id   = aws_api_gateway_resource.get_sentiment.id
  http_method   = "POST"
  authorization = "NONE"
}

#  Luodaan API Gatewaylle deployment dev ympäristöön metodin kokeilua varten
resource "aws_api_gateway_deployment" "get_sentiment" {
  depends_on = [aws_api_gateway_integration.get_sentiment]
  rest_api_id = aws_api_gateway_rest_api.GetSentimentAPI.id
  stage_name = "dev"
  #  Lifecycle policy create_before_destroy sisällytetty, koska auttaa järjestämään uudelleendeployausta
  lifecycle {
    create_before_destroy = true
  }
}

#  Integroidaan API Gateway send_review Lambda-funktion kanssa
resource "aws_api_gateway_integration" "get_sentiment" {
  rest_api_id             = aws_api_gateway_rest_api.GetSentimentAPI.id
  resource_id             = aws_api_gateway_resource.get_sentiment.id
  http_method             = aws_api_gateway_method.send_review.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY" #  This type of integration lets an API method be integrated with the Lambda function invocation action
  uri                     = aws_lambda_function.get_averages.invoke_arn #module.lambda_outputs.post_to_s3_lambda_invoke_arn #  API gateway invocation URI Lambda-funktiolle
}

#  Annetaan API Gatewaylle lupa create_user Lambdan käynnistämiseen
resource "aws_lambda_permission" "send_review" {
  statement_id = "AllowExecutionFromAPIGateway"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.get_averages.function_name #module.lambda_outputs.post_to_s3_lambda_name #  aws_lambda_function.create_user.function_name
  principal = "apigateway.amazonaws.com"
  source_arn = "${aws_api_gateway_rest_api.GetSentimentAPI.execution_arn}/*/*/*" #aws_api_gateway_rest_api.SendReviewAPI.execution_arn/*/POST/send_review #(aws_api_gateway_rest_api.SendReviewAPI.execution_arn/*/POST/send_review) #"arn:aws:execute-api:eu-west-2:821383200340:tsefm0umhk/*/POST/userdata"
}