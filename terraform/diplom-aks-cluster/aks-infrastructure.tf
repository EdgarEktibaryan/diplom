# Description: This file contains the configuration for the AKS cluster Resource

# AKS Cluster User Assifned identity
resource "azurerm_user_assigned_identity" "diplom_aks_identity" {
  location            = var.region
  name                = "diplom-aks-identity"
  resource_group_name = var.resource_group

  depends_on = [azurerm_resource_group.diplom_aks_rg]
}

# AKS Cluster Resource
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster
resource "azurerm_kubernetes_cluster" "diplom_aks" {
  name                             = "diplom-aks"
  resource_group_name              = var.resource_group
  location                         = var.region
  kubernetes_version               = "1.30.10"
  dns_prefix                       = "diplom-aks"

  tags                             = var.tags

  # Identity Configuration for AKS
  identity {
    identity_ids = [azurerm_user_assigned_identity.diplom_aks_identity.id]
    type         = var.identity_type
  }

  # AAD RBAC Configuration for AKS
  azure_active_directory_role_based_access_control {
    admin_group_object_ids = [azuread_group.aks_administrators.object_id]
    azure_rbac_enabled     = true
  }

  # System Node Pool Configuration for AKS
  default_node_pool {
    name                         = "system"
    orchestrator_version         = "1.30.10"
    vnet_subnet_id               = azurerm_subnet.diplom_aks_system_subnet.id
    vm_size                      = "Standard_a2_v2"
    max_pods                     = 30
    node_count                   = 1
    os_sku                       = "Ubuntu"
    os_disk_size_gb              = 30
    kubelet_disk_type            = "OS"
    node_public_ip_enabled  = false
    zones                        = ["1"]
    node_labels                  = {}

    upgrade_settings {
      drain_timeout_in_minutes      = 0
      max_surge                     = "10%"
      node_soak_duration_in_minutes = 0
    }

    tags                         = var.tags
  }

  # Network Profile Configuration for AKS
  network_profile {
    ip_versions    = ["IPv4"]
    network_plugin = "azure"
    dns_service_ip = "10.10.0.10"
    service_cidr   = "10.10.0.0/16"
    outbound_type  = "loadBalancer"

    # Load Balancer Profile Configuration for AKS
    load_balancer_profile {
      outbound_ports_allocated  = 15000
      managed_outbound_ip_count = 1
      idle_timeout_in_minutes   = 30
    }

  }

  depends_on = [azurerm_virtual_network.diplom_aks_vnet, azurerm_user_assigned_identity.diplom_aks_identity]
  
  timeouts {}
}

# Worker Nodes

# Node Pool1 Resource
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool
resource "azurerm_kubernetes_cluster_node_pool" "node01" {
  name                    = "node01"
  orchestrator_version    = "1.30.10"
  kubernetes_cluster_id   = azurerm_kubernetes_cluster.diplom_aks.id
  vnet_subnet_id          = azurerm_subnet.diplom_aks_node01_subnet.id
  vm_size                 = "Standard_a2_v2"
  max_pods                = 30
  node_count              = 1
  os_type                 = "Linux"
  os_sku                  = "Ubuntu"
  os_disk_size_gb         = 64
  kubelet_disk_type       = "OS"
  node_public_ip_enabled  = false
  tags                    = var.tags

  timeouts {}

  depends_on = [azurerm_kubernetes_cluster.diplom_aks]
}
