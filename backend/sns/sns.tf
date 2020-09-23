#  Luodaan SNS topic asiakaspalvelulle
#  Topic ohjaa asiakaspalvelulle automaattisesti erittäin negatiivisen palautteen analysoitavaksi ja nopeasti reagoitavaksi

resource "aws_sns_topic" "customer_service_negative_review" {
  name = "customer-service-negative-review"
}

output "customer_service_sns_arn" {
  value = aws_sns_topic.customer_service_negative_review.arn
}