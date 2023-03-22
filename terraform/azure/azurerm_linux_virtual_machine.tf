resource "azurerm_linux_virtual_machine" "linux_virtual_machine" {
  for_each = local.linux_virtual_machines

  resource_group_name = local.resource_group_name
  location            = local.location

  name = each.value.name

  network_interface_ids = each.value.network_interface_ids
  size                  = local.vm_image["linux_vm"].vm_size

  disable_password_authentication = "false"

  admin_username = local.username
  admin_password = local.password

  identity {
    type = "SystemAssigned"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = local.vm_image["linux_vm"].publisher
    offer     = local.vm_image["linux_vm"].offer
    version   = local.vm_image["linux_vm"].version
    sku       = local.vm_image["linux_vm"].sku
  }

  tags = {
    ComputeType = each.value.compute_type
  }
}
