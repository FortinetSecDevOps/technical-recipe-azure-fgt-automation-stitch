resource "azurerm_route_table" "route_table" {
  resource_group_name = local.resource_group_name
  location            = local.location

  name = "rt-protected"

}

resource "azurerm_route" "route" {
  resource_group_name = local.resource_group_name

  name                   = "rt-default"
  route_table_name       = azurerm_route_table.route_table.name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = azurerm_network_interface.network_interface["nic-port2"].private_ip_address
}

resource "azurerm_subnet_route_table_association" "subnet_route_table_association" {
  subnet_id      = azurerm_subnet.subnet["protected"].id
  route_table_id = azurerm_route_table.route_table.id
}
