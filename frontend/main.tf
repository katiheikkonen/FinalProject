#Nimetään provider
provider "aws" {
  region = "eu-central-1"
}

module "frontend" {
  source = "./frontend_resources/"
}
