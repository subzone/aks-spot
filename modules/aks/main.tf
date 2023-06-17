resource "azurerm_kubernetes_cluster" "aks-spot" {
  name                = "aks-spot"
  location            = var.location
  resource_group_name = var.rgname
  dns_prefix          = "spotaks"

  default_node_pool {
  name                  = "aksspotpool"
#   availability_zone     = "1"
  node_count            = 1
  vm_size               = "Standard_B2ms"
#   spot_instance         = true
#   eviction_policy       = "Deallocate"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Development"
  }
}

# resource "azurerm_kubernetes_cluster_node_pool" "aks-spot-pool" {
#   name                  = "aks-spot-node-pool"
#   node_count            = 3
#   vm_size               = "Standard_D2s_v3"
#   eviction_policy       = "Deallocate"
# }

