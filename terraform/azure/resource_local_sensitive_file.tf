locals {
  fortigate_api_key = format(
    "fortigate_api_token = \"%s\"\nfortigate_ip_or_fqdn = \"%s\"\nresource_group_name = \"%s\"\nroute_table_name = \"%s\"\nnext_hop_ip = \"%s\"\nwebhook = \"%s\"",
    random_string.string.id,
    azurerm_public_ip.public_ip.ip_address,
    azurerm_resource_group.resource_group[0].name,
    azurerm_route_table.route_table.name,
    azurerm_network_interface.network_interface["nic-port2"].private_ip_address,
    azurerm_automation_webhook.automation_webhook.uri
  )
}

resource "local_sensitive_file" "file" {
  filename = "../fortios/fortigate.auto.tfvars"
  content  = local.fortigate_api_key
}