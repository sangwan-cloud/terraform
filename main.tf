# Create a resource group
resource "azurerm_resource_group" "rgterra" {
  name     = "${var.env}-rg-terra"
  location = var.location-name
}