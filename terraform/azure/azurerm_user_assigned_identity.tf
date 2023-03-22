resource "azurerm_user_assigned_identity" "user_assigned_identity" {
  resource_group_name = local.resource_group_name
  location            = local.location

  name = "user-assigned-identity"
}