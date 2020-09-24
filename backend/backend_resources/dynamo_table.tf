resource "aws_dynamodb_table" "sentiment_analysis_data" {
  name = var.dynamodb_table_name
  hash_key = "id"
  billing_mode = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1

  attribute {
    name = "id"
    type = "S"
  }
  tags = {
    Project = "Loppuprojekti"
  }
}

#Luodaan Output, jotta esim terraform apply komennon jälkeen saamme instanssin ip.osoitteen:
output "dynamo_table_sentiment_analysis_data_arn" {
  value = aws_dynamodb_table.sentiment_analysis_data.arn
}

output "dynamo_table_sentiment_analysis_data_name" {
  value = aws_dynamodb_table.sentiment_analysis_data.name
}

output "dynamo_table_sentiment_analysis_data_stream_arn" {
  value = aws_dynamodb_table.sentiment_analysis_data.stream_arn
}