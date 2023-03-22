resource "azurerm_route_table" "route_table" {
  resource_group_name = local.resource_group_name
  location            = local.location

  name = "rt-protected"
}

