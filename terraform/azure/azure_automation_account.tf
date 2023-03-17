resource "azurerm_automation_account" "automation_account" {

  resource_group_name = azurerm_resource_group.resource_group[0].name
  location            = azurerm_resource_group.resource_group[0].location

  name     = format("%s-automation-account", local.username)
  sku_name = "Basic"

  identity {
    type = "SystemAssigned"
  }
}