# Description: This file contains Azure Active Directory resources and role assignments for the AKS cluster

# Role Assignment for AKS Enterprise Application to the AKS VNET
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment
resource "azurerm_role_assignment" "aks_app_vnet_role_assignment" {
  scope                = azurerm_virtual_network.diplom_aks_vnet.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.diplom_aks_identity.principal_id

  depends_on = [azuread_group.aks_administrators, azurerm_kubernetes_cluster.diplom_aks]

  timeouts {}
}

# AAD Group for AKS Administrators
# https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group
resource "azuread_group" "aks_administrators" {
  display_name     = "diplom-aks-admins"
  description      = "Azure AKS Kubernetes administrators for the Diplomayin AKS cluster."
  security_enabled = true

  owners =  [ "f6a8ec04-488d-40b8-b7fe-09f14f6bdef1" ] # Edgar Ektibaryan
  members = [ "f6a8ec04-488d-40b8-b7fe-09f14f6bdef1" ] # Edgar Ektibaryan

  depends_on = [azurerm_resource_group.diplom_aks_rg]
}

# Role Assignment for AKS Administrators group to the AKS cluster
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment
resource "azurerm_role_assignment" "aks_admins_role_assignment" {
  scope                = azurerm_kubernetes_cluster.diplom_aks.id
  role_definition_name = "Owner"
  principal_id         = azuread_group.aks_administrators.object_id

  depends_on = [azuread_group.aks_administrators, azurerm_kubernetes_cluster.diplom_aks]
}

# Role Assignment for AKS Administrators group to the AKS cluster
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment
resource "azurerm_role_assignment" "aks_admins_rbac_role_assignment" {
  scope                = azurerm_kubernetes_cluster.diplom_aks.id
  role_definition_name = "Azure Kubernetes Service RBAC Cluster Admin"
  principal_id         = azuread_group.aks_administrators.object_id

  depends_on = [azuread_group.aks_administrators, azurerm_kubernetes_cluster.diplom_aks]
}