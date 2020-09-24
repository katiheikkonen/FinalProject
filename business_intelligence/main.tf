provider "aws" {
  region = "eu-central-1"
}

module "resources" {
  source = "./business_intelligence_resources/"
}