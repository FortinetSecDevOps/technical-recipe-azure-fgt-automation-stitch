locals {
  fortigate_api_key = format(
    "fortigate_api_token = \"%s\"\nfortigate_ip_or_fqdn = \"%s\"",
    random_string.string.id,
    azurerm_public_ip.public_ip.ip_address
  )
}

resource "local_sensitive_file" "file" {
  filename = "../fortigate/terraform.tfvars"
  content  = local.fortigate_api_key
}