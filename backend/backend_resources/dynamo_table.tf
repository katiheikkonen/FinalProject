provider "aws" {
  alias  = "eu-central-1"
  region = "eu-central-1"
}
provider "aws" {
  alias  = "eu-west-2"
  region = "eu-west-2"
}
resource "aws_dynamodb_table" "eu-central-1" {
  provider = aws.eu-central-1
  hash_key         = "id"
  name             = var.dynamodb_table_name
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
  read_capacity    = 1
  write_capacity   = 1
  attribute {
    name = "id"
    type = "S"
  }
  tags = {
    Project = "Loppuprojekti"
  }
}
resource "aws_dynamodb_table" "eu-west-2" {
  provider = aws.eu-west-2
  hash_key         = "id"
  name             = var.dynamodb_table_name
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
  read_capacity    = 1
  write_capacity   = 1
  attribute {
    name = "id"
    type = "S"
  }
  tags = {
    Project = "Loppuprojekti"
  }
}
resource "aws_dynamodb_global_table" "myTable" {
  depends_on = [
    aws_dynamodb_table.eu-central-1,
    aws_dynamodb_table.eu-west-2,
  ]
  provider = aws.eu-central-1
  name = var.dynamodb_table_name
  replica {
    region_name = "eu-central-1"
  }
  replica {
    region_name = "eu-west-2"
  }
}

//resource "aws_dynamodb_table" "sentiment_analysis_data" {
//  name = var.dynamodb_table_name
//  hash_key = "id"
//  billing_mode = "PROVISIONED"
//  read_capacity  = 1
//  write_capacity = 1
//
//  attribute {
//    name = "id"
//    type = "S"
//  }

//}

#Luodaan Output, jotta esim terraform apply komennon jälkeen saamme instanssin ip.osoitteen:
output "dynamo_table_sentiment_analysis_data_arn" {
  value = aws_dynamodb_table.eu-central-1.arn
}

output "dynamo_table_sentiment_analysis_data_name" {
  value = aws_dynamodb_table.eu-central-1.name
}

output "dynamo_table_sentiment_analysis_data_stream_arn" {
  value = aws_dynamodb_table.eu-central-1.stream_arn
}