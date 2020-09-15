#  LUODAAN API GATEWAY

resource "aws_api_gateway_rest_api" "mystocksapi" {
  name        = "MyStocksAPI"
  description = "API for MyStocks-app"
}

#  LUODAAN API GATEWAY RESOURCES

#  Luodaan mystocks APIlle polku userdata tauluun
resource "aws_api_gateway_resource" "userdata" {
  rest_api_id = aws_api_gateway_rest_api.mystocksapi.id
  parent_id   = aws_api_gateway_rest_api.mystocksapi.root_resource_id #  API Gatewayn pääpolun määrittely
  path_part   = "userdata" # API Gatewayn alapolku jonka alle metodi laitetaan, tässä tapauksessa DynamoDB:n taulun nimi
}

#  Luodaan mystocks APIlle polku userdata/{id}
resource "aws_api_gateway_resource" "userdata_id" {
  rest_api_id = aws_api_gateway_rest_api.mystocksapi.id
  parent_id   = aws_api_gateway_resource.userdata.parent_id #  API Gatewayn pääpolun määrittely
  path_part   = "{id}" # API Gatewayn alapolku jonka alle metodi laitetaan, tässä tapauksessa DynamoDB:n taulun nimi
}

#  Tuodaan lambda-moduuli CRUD-toimintojen käyttöön
module "lambda" {
source  = "../lambda"
}