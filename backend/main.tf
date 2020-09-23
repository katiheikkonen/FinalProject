#Nimetään provider
provider "aws" {
  region = "eu-central-1" #kova koodattuna, mutta myöhemmin mapattuna

}

module "state_machine" {
  source = "./state_machine_and_lambdas/state_machine/"
}

