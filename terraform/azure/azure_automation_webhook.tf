resource "azurerm_automation_webhook" "automation_webhook" {

  resource_group_name = local.resource_group_name

  name                    = "Update-RouteTable_webhook"
  automation_account_name = azurerm_automation_account.automation_account[format("%s-automation-account", local.username)].name
  expiry_time             = "2024-12-31T00:00:00Z"
  enabled                 = true
  runbook_name            = azurerm_automation_runbook.automation_runbook.name

}