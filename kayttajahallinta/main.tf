#Nimetään provider
provider "aws" {
  region = "eu-central-1" #kova koodattuna, mutta myöhemmin mapattuna
  #access_key = ""
  #secret_key = ""
}

module "lambda" {
  source = "./lambda"
}
module "api_gateway" {
  source = "./api_gateway"
}

