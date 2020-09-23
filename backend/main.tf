#Nimetään provider
provider "aws" {
  region = "eu-central-1" #kova koodattuna, mutta myöhemmin mapattuna
  #access_key = ""
  #secret_key = ""
}

//module "s3" {
//  source = "./s3/"
//}
//
//module "dynamo_db" {
//  source = "./dynamodb/"
//}
module "lambda" {
  source = "./lambda/"
}



