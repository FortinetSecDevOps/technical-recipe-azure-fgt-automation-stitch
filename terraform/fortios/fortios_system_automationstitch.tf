resource "fortios_system_automationstitch" "system_automationstitch" {
  for_each = local.system_automationstitches

  name        = each.value.name
  description = each.value.description
  status      = each.value.status

  trigger = each.value.trigger
  actions {
    action = each.value.action_name
  }
}
