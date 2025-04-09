# Description: This file contains the network Resources for the AKS cluster

# Main Virtual Network Resource
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network
resource "azurerm_virtual_network" "diplom_aks_vnet" {
  name                = "diplom-aks-vnet"
  resource_group_name = var.resource_group
  location            = var.region
  dns_servers         = []
  address_space       = ["192.168.0.0/16"]
  tags                = var.tags

  depends_on = [azurerm_resource_group.diplom_aks_rg]

  timeouts {}
}

resource "azurerm_subnet" "diplom_aks_system_subnet" {
  name                 = "system-subnet"
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.diplom_aks_vnet.name
  address_prefixes     = ["192.168.10.0/24"]
}

resource "azurerm_subnet" "diplom_aks_node01_subnet" {
  name                 = "node01-subnet"
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.diplom_aks_vnet.name
  address_prefixes     = ["192.168.15.0/24"]
}

# AKS Public IP resource
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip 
resource "azurerm_public_ip" "diplom_aks_pip" {
  name                    = "diplom-aks-pip"
  resource_group_name     = azurerm_kubernetes_cluster.diplom_aks.node_resource_group
  domain_name_label       = var.domain_name_label
  location                = var.region
  allocation_method       = "Static"
  ddos_protection_mode    = "VirtualNetworkInherited"
  idle_timeout_in_minutes = 4
  ip_version              = "IPv4"
  sku                     = "Standard"
  # sku_tier                = "Regional"
  # zones                   = ["1", "2", "3"]
  tags                    = var.tags_pubip

  depends_on = [azurerm_kubernetes_cluster.diplom_aks]

  timeouts {}
}