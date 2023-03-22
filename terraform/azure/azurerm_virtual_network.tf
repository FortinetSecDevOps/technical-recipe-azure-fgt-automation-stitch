resource "azurerm_virtual_network" "virtual_network" {
  resource_group_name = local.resource_group_name
  location            = local.location

  name          = local.virtual_network_name
  address_space = [local.virtual_network_address_space]

  tags = {
    environment = local.environment_tag
  }
}
