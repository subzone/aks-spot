terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.61.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  skip_provider_registration = "true"
  features {}
}

module "azurerm_resource_group" {
  source = "./modules/resource_group"

  rgname = join("-",["rg-aks",var.location])
  location = var.location
}

module "azurerm_aks" {
  source = "./modules/aks"

  rgname = module.azurerm_resource_group.rgname
  location = module.azurerm_resource_group.location
}