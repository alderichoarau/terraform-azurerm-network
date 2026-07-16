terraform {
  required_version = ">= 1.9"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "rg-example-network"
  location = "francecentral"
}

module "network" {
  source  = "app.terraform.io/alderic-hoarau/network/azurerm"
  version = "~> 0.1"

  name                = "example"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  tags = {
    owner = "example"
  }
}

output "vnet_id" {
  value = module.network.vnet_id
}
