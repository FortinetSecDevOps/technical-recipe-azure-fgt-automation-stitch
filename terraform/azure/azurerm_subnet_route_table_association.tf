resource "azurerm_subnet_route_table_association" "subnet_route_table_association" {
  subnet_id      = azurerm_subnet.subnet["protected"].id
  route_table_id = azurerm_route_table.route_table.id
}
