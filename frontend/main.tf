#Nimetään provider
provider "aws" {
  region = "eu-central-1" #kova koodattuna, mutta myöhemmin mapattuna
  #access_key = ""
  #secret_key = ""
}

module "api_gateway_and_lambda" {
  source = "./api_gateway_and_lambda/"
}
