data "azurerm_resource_group" "diplom_rg" {
  name = "diplom-rg"
}

data "azurerm_storage_account" "diplomtfstate" {
  name                = "diplomtfstate"
  resource_group_name = data.azurerm_resource_group.diplom_rg.name
}
