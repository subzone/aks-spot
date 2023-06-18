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
#   vm_size               = "Standard_B2ms"
  
#   spot_max_price = ""
#   eviction_policy       = "Deallocate"
# }

resource "azurerm_kubernetes_cluster_node_pool" "nodepool_cpu_spot" {
  enable_auto_scaling   = true
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks-spot.id
  max_count             = 3
  min_count             = 1
  mode                  = "User"
  name                  = "cpuspot"
  #orchestrator_version  = data.azurerm_kubernetes_service_versions.current.latest_version
  orchestrator_version  = azurerm_kubernetes_cluster.aks-spot.kubernetes_version
  os_disk_size_gb       = 128
  os_type               = "Linux" # Default is Linux, we can change to Windows
  vm_size               = "standard_B2ms" # "Standard_NC6_Promo" Promo is not available for Spot instances
  priority              = "Spot"  # Default is Regular, we can change to Spot with additional settings like eviction_policy, spot_max_price, node_labels and node_taints
  spot_max_price        = "0.5" # Set to -1 to disable the max_price (not eviction based on price)
  eviction_policy       = "Delete" # Deallocate will count against your quota and there is no guarantee the node can be realocated
#   vnet_subnet_id        = azurerm_subnet.aks-subnet.id  
  node_taints = ["kubernetes.azure.com/scalesetpriority=spot:NoSchedule"]
  node_labels = {
    "nodepool-type" = "user"
    "environment"   = var.environment
    "nodepoolos"    = "linux"
    "sku"           = "cpu"    
    "kubernetes.azure.com/scalesetpriority" = "spot"
  }
  tags = {
    "nodepool-type" = "user"
    "environment"   = var.environment
    "nodepoolos"    = "linux"
    "sku"           = "cpu"    
  }
}
