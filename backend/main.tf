#Nimetään provider
provider "aws" {
  region = "eu-central-1" #kova koodattuna, mutta myöhemmin mapattuna
  #access_key = ""
  #secret_key = ""
}

module "dynamo_db" {
  source = "./dynamodb/"
}
module "lambda" {
  source = "./lambda/"
}

module "s3" {
  source = "./s3/"
}

