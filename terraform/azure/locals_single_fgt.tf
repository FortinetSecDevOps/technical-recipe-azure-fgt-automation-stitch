locals {
  username = var.username
  password = "Fortinet123#"

  resource_group_exists        = true
  resource_group_name_combined = "${local.username}-${var.resource_group_name_suffix}"

  license_file        = ""
  fgtvm_configuration = "fgtvm.conf"

  location = "eastus"

  resource_group_name     = local.resource_group_exists ? data.azurerm_resource_group.resource_group.0.name : azurerm_resource_group.resource_group.0.name
  resource_group_location = local.resource_group_exists ? data.azurerm_resource_group.resource_group.0.location : azurerm_resource_group.resource_group.0.location
  resource_group_id       = local.resource_group_exists ? data.azurerm_resource_group.resource_group.0.id : azurerm_resource_group.resource_group.0.id

  environment_tag               = "Terraform Single FortiGate"
  virtual_network_name          = "vnet-single-fortigate"
  virtual_network_address_space = "10.1.0.0/16"

  vm_image = {
    "fortigate" = {
      publisher    = "fortinet"
      offer        = "fortinet_fortigate-vm_v5"
      vm_size      = "Standard_DS2_v2"
      version      = "latest" # can be a version number as well, e.g. 6.4.9, 7.0.6, 7.2.0
      license_type = "payg"   # can be byol, flex, or payg, make sure the license is correct for the sku
      sku = {
        byol = "fortinet_fg-vm2"
        payg = "fortinet_fg-vm_payg_2022"
      } # byol and flex use: fortinet_fg-vm | payg use: fortinet_fg-vm_payg_2022
    }
    "linux_vm" = {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      vm_size   = "Standard_F2"
      version   = "latest"
      sku       = "16.04-LTS"
    }
  }

  subnets = {
    "external" = {
      resource_group_name = local.resource_group_name

      name                 = "external"
      virtual_network_name = local.virtual_network_name
      address_prefixes     = [cidrsubnet(azurerm_virtual_network.virtual_network.address_space[0], 8, 0)]
    }
    "internal" = {
      resource_group_name = local.resource_group_name

      name                 = "internal"
      virtual_network_name = local.virtual_network_name
      address_prefixes     = [cidrsubnet(azurerm_virtual_network.virtual_network.address_space[0], 8, 1)]
    }
    "protected" = {
      resource_group_name = local.resource_group_name

      name                 = "protected"
      virtual_network_name = local.virtual_network_name
      address_prefixes     = [cidrsubnet(azurerm_virtual_network.virtual_network.address_space[0], 8, 2)]
    }
  }

  network_interfaces = {
    "nic-port1" = {
      resource_group_name = local.resource_group_name
      location            = local.location

      name                          = "nic-port1"
      enable_ip_forwarding          = true
      enable_accelerated_networking = true

      ip_configurations = [
        {
          name                          = "ipconfig1"
          subnet_id                     = azurerm_subnet.subnet["external"].id
          private_ip_address_allocation = "Static"
          private_ip_address            = cidrhost(azurerm_subnet.subnet["external"].address_prefixes[0], 4)
          public_ip_address_id          = azurerm_public_ip.public_ip.id
        }
      ]
    }
    "nic-port2" = {
      resource_group_name = local.resource_group_name
      location            = local.location

      name                          = "nic-port2"
      enable_ip_forwarding          = true
      enable_accelerated_networking = true

      ip_configurations = [
        {
          name                          = "ipconfig1"
          subnet_id                     = azurerm_subnet.subnet["internal"].id
          private_ip_address_allocation = "Static"
          private_ip_address            = cidrhost(azurerm_subnet.subnet["internal"].address_prefixes[0], 4)
          public_ip_address_id          = null
        }
      ]
    }
    "linux-1-nic-1" = {
      resource_group_name = local.resource_group_name
      location            = local.location

      name                          = "linux-1-nic-1"
      enable_ip_forwarding          = false
      enable_accelerated_networking = false

      ip_configurations = [
        {
          name                          = "ipconfig1"
          subnet_id                     = azurerm_subnet.subnet["protected"].id
          private_ip_address_allocation = "Static"
          private_ip_address            = cidrhost(azurerm_subnet.subnet["protected"].address_prefixes[0], 4)
          public_ip_address_id          = null
        }
      ]
    }
    "linux-2-nic-1" = {
      resource_group_name = local.resource_group_name
      location            = local.location

      name                          = "linux-2-nic-1"
      enable_ip_forwarding          = false
      enable_accelerated_networking = false

      ip_configurations = [
        {
          name                          = "ipconfig1"
          subnet_id                     = azurerm_subnet.subnet["protected"].id
          private_ip_address_allocation = "Static"
          private_ip_address            = cidrhost(azurerm_subnet.subnet["protected"].address_prefixes[0], 5)
          public_ip_address_id          = null
        }
      ]
    }
  }

  network_security_groups = {
    "nsg_external" = {
      resource_group_name = local.resource_group_name
      location            = local.location

      name = "nsg_external"
    }
    "nsg_internal" = {
      resource_group_name = local.resource_group_name
      location            = local.location

      name = "nsg_internal"
    }
  }

  network_security_rules = {
    "nsr_external_ingress" = {
      resource_group_name = local.resource_group_name

      name                        = "nsr_external_ingress"
      priority                    = 1001
      direction                   = "Inbound"
      access                      = "Allow"
      protocol                    = "*"
      source_port_range           = "*"
      destination_port_range      = "*"
      source_address_prefix       = "*"
      destination_address_prefix  = "*"
      network_security_group_name = azurerm_network_security_group.network_security_group["nsg_external"].name
    },
    "nsr_external_egress" = {
      resource_group_name = local.resource_group_name

      name                        = "nsr_external_egress"
      priority                    = 1002
      direction                   = "Outbound"
      access                      = "Allow"
      protocol                    = "*"
      source_port_range           = "*"
      destination_port_range      = "*"
      source_address_prefix       = "*"
      destination_address_prefix  = "*"
      network_security_group_name = azurerm_network_security_group.network_security_group["nsg_external"].name
    },
    "nsr_internal_ingress" = {
      resource_group_name = local.resource_group_name

      name                        = "nsr_internal_ingress"
      priority                    = 1001
      direction                   = "Inbound"
      access                      = "Allow"
      protocol                    = "*"
      source_port_range           = "*"
      destination_port_range      = "*"
      source_address_prefix       = "*"
      destination_address_prefix  = "*"
      network_security_group_name = azurerm_network_security_group.network_security_group["nsg_internal"].name
    },
    "nsr_internal_egress" = {
      resource_group_name = local.resource_group_name

      name                        = "nsr_internal_egress"
      priority                    = 1002
      direction                   = "Outbound"
      access                      = "Allow"
      protocol                    = "*"
      source_port_range           = "*"
      destination_port_range      = "*"
      source_address_prefix       = "*"
      destination_address_prefix  = "*"
      network_security_group_name = azurerm_network_security_group.network_security_group["nsg_internal"].name
    }
  }

  linux_virtual_machines = {
    "vm-linux-1" = {
      name                  = "vm-linux-1"
      network_interface_ids = [azurerm_network_interface.network_interface["linux-1-nic-1"].id]
      compute_type          = "unknown"
    }
    "vm-linux-2" = {
      name                  = "vm-linux-2"
      network_interface_ids = [azurerm_network_interface.network_interface["linux-2-nic-1"].id]
      compute_type          = "WebServer"
    }
  }

  role_assignments = {
    "vm-fgt" = {
      scope                = azurerm_resource_group.resource_group[0].id
      role_definition_name = "Contributor"
      principal_id         = azurerm_virtual_machine.virtual_machine.identity[0].principal_id
    }
    "automation-account" = {
      scope                = azurerm_resource_group.resource_group[0].id
      role_definition_name = "Contributor"
      principal_id         = azurerm_automation_account.automation_account.identity[0].principal_id
    }
  }
}