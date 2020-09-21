#  LUODAAN API GATEWAY

resource "aws_api_gateway_rest_api" "GetSentimentAPI" {
  name        = "GetSentimentApi"
  description = "API for fetching customer sentiment"
  tags = {
    Project = "Loppuprojekti"
  }
}