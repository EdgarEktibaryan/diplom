# Description: This file contains Resource group for AKS cluster and its Resources

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
resource "azurerm_resource_group" "diplom_aks_rg" {
  name     = var.resource_group
  location = var.region
  tags     = var.tags
}
