output "ResourceGroup" {
  value = local.resource_group_name
}

output "FortiGate_Public_IP" {
  value = format("https://%s", azurerm_public_ip.public_ip.ip_address)
}

output "credentials" {
  value     = format("username: %s / password: %s", local.username, local.password)
  sensitive = true
}

output "api_key" {
  value = random_string.string.id
}