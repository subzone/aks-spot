resource "azurerm_virtual_network" "aks_vnet" {
  name = join("-",["aks-vnet",var.environment])
  resource_group_name = var.rgname
  location = var.location
}

resource "azurerm_subnet" "aks-subnet" {
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  resource_group_name = var.rgname
}