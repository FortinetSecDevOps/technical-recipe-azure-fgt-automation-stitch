locals {
  linuxhostname = "vm-lnx"
}

resource "azurerm_linux_virtual_machine" "linux_virtual_machine" {
  resource_group_name = local.resource_group_name
  location            = local.location

  name = local.linuxhostname

  network_interface_ids = [azurerm_network_interface.network_interface["linux-nic-port1"].id]
  size                  = "Standard_F2"

  disable_password_authentication = "false"
  admin_username        = local.username
  admin_password        = local.password

  identity {
    type = "SystemAssigned"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}
