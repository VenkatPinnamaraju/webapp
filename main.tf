terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">=3.0"
    }
  }
}

provider "azurerm" {
  features {
    
  }
}


resource "azurerm_resource_group" "ven1_aks_rg" {
  name     = "ven1-aks-rg"
  location = "UK South"
}

resource "azurerm_kubernetes_cluster" "ven1_aks" {
  name                = "ven1-aks1"
  location            = azurerm_resource_group.ven1_aks_rg.location
  resource_group_name = azurerm_resource_group.ven1_aks_rg.name
  dns_prefix          = "ven1-aks1"

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

resource "azurerm_kubernetes_cluster_node_pool" "ven1_np" {
  name                  = "vennp1"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.ven1_aks.id
  vm_size               = "Standard_DS2_v2"
  node_count            = 1

  tags = {
    Environment = "test"
  }
}
