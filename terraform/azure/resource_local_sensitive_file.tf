locals {
  fortigate_api_key = format(
    "fortigate_api_token = \"%s\"\nfortigate_ip_or_fqdn = \"%s\"\nresource_group_name = \"%s\"\nroute_table_name = \"%s\"",
    random_string.string.id,
    azurerm_public_ip.public_ip.ip_address,
    azurerm_resource_group.resource_group[0].name,
    azurerm_route_table.route_table.name
  )
}

resource "local_sensitive_file" "file" {
  filename = "../fortigate/terraform.tfvars"
  content  = local.fortigate_api_key
}