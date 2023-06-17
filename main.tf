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

  rgname = var.rgname
  location = var.location
}

module "azurerm_aks" {
  source = "./modules/aks"

  resource_group_name = module.azurerm_resource_group.rgname
  location = var.location
}