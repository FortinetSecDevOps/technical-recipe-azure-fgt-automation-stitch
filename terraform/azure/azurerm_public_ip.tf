resource "azurerm_public_ip" "public_ip" {
  resource_group_name = local.resource_group_name
  location            = local.location

  name              = "pip_fgt"
  allocation_method = "Static"
  sku               = "Standard"
}
