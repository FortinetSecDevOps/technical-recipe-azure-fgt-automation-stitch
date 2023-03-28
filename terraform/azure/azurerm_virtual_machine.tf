resource "azurerm_virtual_machine" "virtual_machine" {
  for_each = local.virtual_machines

  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  name = each.value.name

  network_interface_ids        = each.value.network_interface_ids
  primary_network_interface_id = each.value.primary_network_interface_id
  vm_size                      = local.vm_image[each.value.vm_image].vm_size

  delete_os_disk_on_termination    = each.value.delete_os_disk_on_termination
  delete_data_disks_on_termination = each.value.delete_data_disks_on_termination

  identity {
    type = each.value.identity_type
  }

  storage_image_reference {
    publisher = local.vm_image[each.value.vm_image].publisher
    offer     = local.vm_image[each.value.vm_image].offer
    sku       = local.vm_image[each.value.vm_image].sku
    version   = local.vm_image[each.value.vm_image].version
  }

  plan {
    name      = local.vm_image[each.value.vm_image].sku
    publisher = local.vm_image[each.value.vm_image].publisher
    product   = local.vm_image[each.value.vm_image].offer
  }

  storage_os_disk {
    name              = each.value.storage_os_disk_name
    caching           = each.value.storage_os_disk_caching
    create_option     = each.value.storage_os_disk_create_option
    managed_disk_type = each.value.storage_os_disk_managed_disk_type
  }

  # Log data disks
  storage_data_disk {
    name              = each.value.storage_data_disk_name
    create_option     = each.value.storage_data_disk_create_option
    disk_size_gb      = each.value.storage_data_disk_disk_size_gb
    lun               = each.value.storage_data_disk_lun
    managed_disk_type = each.value.storage_data_disk_managed_disk_type
  }

  os_profile {
    computer_name  = each.value.name
    admin_username = local.username
    admin_password = local.password
    custom_data = templatefile("${local.fgtvm_configuration}", {
      hostname     = each.value.name
      api_key      = random_string.string.id
      type         = local.vm_image[each.value.vm_image].sku
      license_file = local.license_file
    })
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  boot_diagnostics {
    enabled     = true
    storage_uri = ""
  }
}
