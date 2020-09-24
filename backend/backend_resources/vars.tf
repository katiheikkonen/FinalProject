variable "dynamodb_table_name" {
  default = "sentiment_data_analysis_global_table"
}

variable "s3_bucket_name_customer_review" {
  default = "customer-reviews-loppuprojekti"
}

variable "s3_bucket_name_archival" {
  default = "archival-loppuprojekti"
}

variable "state_machine_name" {
  default = "sentimental-analysis-state-machine"
}