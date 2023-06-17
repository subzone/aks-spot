resource "azurerm_resource_group" "aks-spot-rg" {
    name = join("-",["rg-aks",var.location])
    location = var.location 
}