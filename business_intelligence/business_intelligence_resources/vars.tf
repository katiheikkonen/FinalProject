#  DynamoDB taulun nimi get sentiment lambdaa varten
variable "environmental_table_name" {
  type = string
  description = "name of the dynamoDB table we want to do queries against"
  default = "sentiment_data_analysis_global_table"
}
# DynamoDB eu-central-1 stream arn put_to_analysis_s3 lambdaa varten
variable "global_table_stream_arn" {
  default: "arn:aws:dynamodb:eu-central-1:821383200340:table/sentiment_data_analysis_global_table/stream/2020-09-24T07:52:56.372"
}
# DynamoDB eu-central-1 arn
variable "global_table_eu_central_1_arn" {
  default: "arn:aws:dynamodb:eu-central-1:821383200340:table/sentiment_data_analysis_global_table"
}
