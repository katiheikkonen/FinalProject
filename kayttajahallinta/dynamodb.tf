resource "aws_dynamodb_table" "userdata_dynamodb" {
  name = "userdata"
  hash_key = "user_id"
  billing_mode = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  attribute {
    name = "user_id"
    type = "S"
  }
}

#Luodaan Output, jotta esim terraform apply komennon jälkeen saamme instanssin ip.osoitteen:
output "dynamo_table_userdata_arn" {
  value = aws_dynamodb_table.userdata_dynamodb.arn
}

output "dynamo_table_userdata_name" {
  value = aws_dynamodb_table.userdata_dynamodb.name
}