#Nimetään provider
provider "aws" {
  region = "eu-west-2" #kova koodattuna, mutta myöhemmin mapattuna
  #access_key = ""
  #secret_key = ""
}
//
//module "lambda" {
//  source = "./lambda"
//}
module "api_gateway" {
  source = "./api_gateway"
}
//module "dynamo_tables" {
//  source = "./dynamo_tables"
//}

