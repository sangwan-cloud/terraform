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
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.58.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

#create resource group
resource "azurerm_resource_group" "rg" {
    name     = "jenkins-terraform"
    location = "uksouth"
}