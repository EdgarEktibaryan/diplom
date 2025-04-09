# Description: This file contains the providers used in the terraform code

# Terraform Cloud Provider Configuration 
terraform {
  backend "azurerm" {}
}

# AzureRM Provider Configuration 
provider "azurerm" {
  subscription_id = var.azure_subscription_id
  tenant_id       = var.azure_tenant_id
  features {}
}

# Helm Provider Configuration 
provider "helm" {
  kubernetes {
  host                   = "${data.azurerm_kubernetes_cluster.data_diplom_aks.kube_admin_config.0.host}"
  client_certificate     = "${base64decode(data.azurerm_kubernetes_cluster.data_diplom_aks.kube_admin_config.0.client_certificate)}"
  client_key             = "${base64decode(data.azurerm_kubernetes_cluster.data_diplom_aks.kube_admin_config.0.client_key)}"
  cluster_ca_certificate = "${base64decode(data.azurerm_kubernetes_cluster.data_diplom_aks.kube_admin_config.0.cluster_ca_certificate)}"
  }
}
# Kubernetes Cluster Data Source
data "azurerm_kubernetes_cluster" "data_diplom_aks" {
  name                = azurerm_kubernetes_cluster.diplom_aks.name
  resource_group_name = azurerm_kubernetes_cluster.diplom_aks.resource_group_name

  depends_on = [
    azurerm_kubernetes_cluster.diplom_aks
  ]
}

# Kubernetes Provider Configuration
provider "kubernetes" {
  host                   = "${data.azurerm_kubernetes_cluster.data_diplom_aks.kube_admin_config.0.host}"
  client_certificate     = "${base64decode(data.azurerm_kubernetes_cluster.data_diplom_aks.kube_admin_config.0.client_certificate)}"
  client_key             = "${base64decode(data.azurerm_kubernetes_cluster.data_diplom_aks.kube_admin_config.0.client_key)}"
  cluster_ca_certificate = "${base64decode(data.azurerm_kubernetes_cluster.data_diplom_aks.kube_admin_config.0.cluster_ca_certificate)}"
}

# AzureAD Provider Configuration
provider "azuread" {
    tenant_id = var.azure_tenant_id
}

