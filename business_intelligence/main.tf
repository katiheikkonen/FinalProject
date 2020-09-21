provider "aws" {
  region = "eu-central-1"
}

module "api_gateway" {
  source = "./api_and_lambda"
}