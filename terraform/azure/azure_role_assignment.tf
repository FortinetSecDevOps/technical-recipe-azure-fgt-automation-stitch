resource "azurerm_role_assignment" "role_assignment" {

  scope                = azurerm_resource_group.resource_group[0].id
  role_definition_name = "Reader"
  principal_id         = azurerm_virtual_machine.virtual_machine.identity[0].principal_id
}
