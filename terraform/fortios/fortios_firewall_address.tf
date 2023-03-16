resource "fortios_firewall_address" "firewall_address" {
  for_each = local.firewall_addresses

  name   = each.value.name
  type   = each.value.type
  sdn    = each.value.sdn
  filter = each.value.filter
}