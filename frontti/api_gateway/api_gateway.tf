#  LUODAAN API GATEWAY

resource "aws_api_gateway_rest_api" "SendReviewAPI" {
  name        = "SendReviewAPI"
  description = "API for posting customer review"
}

#  LUODAAN API GATEWAY RESOURCE

//#  Tuodaan lambda-moduuli POST-toiminnon käyttöön
//module "lambda_outputs" {
//source  = "../lambda"
//}