terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terra"
    storage_account_name = "storageterraformbackend"
    container_name       = "tfstate"
    key                  = "devops.jenkins.terraform.tfstate"
  }
}