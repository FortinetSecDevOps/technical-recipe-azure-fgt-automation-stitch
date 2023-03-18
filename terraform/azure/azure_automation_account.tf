resource "azurerm_automation_account" "automation_account" {

  resource_group_name = local.resource_group_name
  location            = local.location

  name     = format("%s-automation-account", local.username)
  sku_name = "Basic"

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.user_assigned_identity.id]
  }
}