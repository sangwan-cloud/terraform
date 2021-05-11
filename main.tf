#Set up remote state
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terra"
    storage_account_name = "storageterraformbackend"
    container_name       = "tfstate"
    key                  = "jenkins.terraform.tfstate"
  }
}

#configure azurerm provider
provider "azurerm" {
  version = "2.46.0"
}

#create resource group
resource "azurerm_resource_group" "rg" {
    name     = "jenkins-terraform"
    location = "westus2"
}