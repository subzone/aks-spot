resource "azurerm_resource_group" "aks-spot-rg" {
    name = var.rgname
    location = var.location 
}