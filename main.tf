terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">=3.0"
    }
  }
backend "azurerm" {
    resource_group_name = "ven-stg"
    storage_account_name = "venstg123"
    container_name = "vennew"
    key = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {
    
  }
}
variable "aks_cluster_name" {
  type = string
}

resource "azurerm_resource_group" "ven1_aks_rg" {
  name     = "ven1-aks-rg"
  location = "UK South"
}

resource "azurerm_kubernetes_cluster" "ven1_aks" {
  name                = var.aks_cluster_name
  location            = azurerm_resource_group.ven1_aks_rg.location
  resource_group_name = azurerm_resource_group.ven1_aks_rg.name
  dns_prefix          = var.aks_cluster_name

  default_node_pool {
    name       = "venpool1"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  service_principal {
    client_id     = "990b7bfc-6f00-48b1-941e-58476eeaf976"
    client_secret = "iJO8Q~yxUiuOuM1uRUq3ZYQWb1Mh9ifh3fRhicAw"
  }
}


