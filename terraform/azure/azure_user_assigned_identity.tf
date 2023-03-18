resource "azurerm_user_assigned_identity" "user_assigned_identity" {
  resource_group_name = azurerm_resource_group.resource_group[0].name
  location            = azurerm_resource_group.resource_group[0].location

  name = "user-assigned-identity"
}