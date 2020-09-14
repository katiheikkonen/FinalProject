resource "aws_api_gateway_rest_api" "mystocksapi" {
  name        = "MyStocksAPI" #  "var.name"
  description = "API for MyStocks-app"
}

