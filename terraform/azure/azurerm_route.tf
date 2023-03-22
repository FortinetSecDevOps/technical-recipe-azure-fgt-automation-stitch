resource "azurerm_route" "route" {
  resource_group_name = local.resource_group_name

  name                   = "rt-default"
  route_table_name       = azurerm_route_table.route_table.name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = azurerm_network_interface.network_interface["nic-port2"].private_ip_address
}
