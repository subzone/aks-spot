resource "azurerm_kubernetes_cluster" "aks-spot" {
  name                = "aks-spot"
  location            = azurerm_resource_group.aks-spot-rg.location
  resource_group_name = azurerm_resource_group.aks-spot-rg.name
  dns_prefix          = "spotaks"

  default_node_pool {
  name                  = "aks-spot-node-pool"
  availability_zone     = "1"
  node_count            = 3
  vm_size               = "Standard_D2s_v3"
  spot_instance         = true
  eviction_policy       = "Deallocate"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Development"
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "aks-spot-pool" {
  name                  = "aks-spot-node-pool"
  availability_zone     = "1"
  node_count            = 3
  vm_size               = "Standard_D2s_v3"
  spot_instance         = true
  eviction_policy       = "Deallocate"

  # Other node pool configuration
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.aks-spot.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks-spot.kube_config_raw

  sensitive = true
}