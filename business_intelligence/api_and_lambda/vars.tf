variable "environmental_table_name" {
  type = string
  description = "name of the dynamoDB table we want to do queries against"
  default = "sentiment_data_analysis_table"
}
