resource "azurerm_linux_virtual_machine" "linux_virtual_machine" {
  for_each = local.linux_virtual_machines

  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  name = each.value.name

  network_interface_ids = each.value.network_interface_ids
  size                  = local.vm_image[each.value.vm_image].vm_size

  disable_password_authentication = each.value.disable_password_authentication

  admin_username = local.username
  admin_password = local.password

  identity {
    type = each.value.identity_type
  }

  os_disk {
    name                 = each.value.os_disk_name
    caching              = each.value.os_disk_caching
    storage_account_type = each.value.os_disk_storage_account_type
  }

  source_image_reference {
    publisher = local.vm_image[each.value.vm_image].publisher
    offer     = local.vm_image[each.value.vm_image].offer
    version   = local.vm_image[each.value.vm_image].version
    sku       = local.vm_image[each.value.vm_image].sku
  }

  boot_diagnostics {
    storage_account_uri = ""
  }

  tags = {
    ComputeType = each.value.tags_ComputeType
  }
}
