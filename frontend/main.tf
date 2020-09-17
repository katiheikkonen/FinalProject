#Nimetään provider
provider "aws" {
  region = "eu-central-1" #kova koodattuna, mutta myöhemmin mapattuna
  #access_key = ""
  #secret_key = ""
}

module "api_gateway" {
  source = "./api_gateway_and_lambda/"
}
#module "lambda" {
#  source = "./lambda/"
#}
