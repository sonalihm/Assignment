resource "azurerm_resource_group" "rg_poc" {
  name     = var.resource_group
  location = var.location

  tags = {
    Environment  = "POC",
    Organization = "ThoughtWorks"
  }
}

resource "azurerm_container_registry" "acr_poc" {
  name                = "akspocsacr"
  resource_group_name = azurerm_resource_group.rg_poc.name
  location            = azurerm_resource_group.rg_poc.location
  sku                 = "Basic"
  admin_enabled       = true

  tags = {
    Environment  = "POC",
    Organization = "ThoughtWorks"
  }
}

resource "azurerm_kubernetes_cluster" "aks_poc" {
  name                = "aks-poc-cluster"
  location            = azurerm_resource_group.rg_poc.location
  resource_group_name = azurerm_resource_group.rg_poc.name
  dns_prefix          = "akspocprefix"

  default_node_pool {
    name            = "default"
    node_count      = 1
    vm_size         = "Standard_D2s_v3"
    os_disk_size_gb = 30
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment  = "POC",
    Organization = "ThoughtWorks"
  }
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks_poc.kube_config_raw
}

output "acr_login_server" {
  value = azurerm_container_registry.acr_poc.login_server
}

output "acr_username" {
  value = azurerm_container_registry.acr_poc.admin_username
}

output "acr_password" {
  value = azurerm_container_registry.acr_poc.admin_password
}
