resource "azurerm_network_interface_security_group_association" "port1nsg" {
  network_interface_id      = azurerm_network_interface.network_interface["nic-port1"].id
  network_security_group_id = azurerm_network_security_group.network_security_group["nsg_external"].id
}

resource "azurerm_network_interface_security_group_association" "port2nsg" {
  network_interface_id      = azurerm_network_interface.network_interface["nic-port2"].id
  network_security_group_id = azurerm_network_security_group.network_security_group["nsg_internal"].id
}