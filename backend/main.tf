#Nimetään provider
provider "aws" {
  region = "eu-central-1" #kova koodattuna, mutta myöhemmin mapattuna

}

module "backend" {
  source = "./backend_resources/"
}

