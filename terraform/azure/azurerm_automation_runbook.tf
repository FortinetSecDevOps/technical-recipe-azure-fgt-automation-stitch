resource "azurerm_automation_runbook" "automation_runbook" {

  resource_group_name = local.resource_group_name
  location            = local.location

  name                    = "Update-RouteTable"
  automation_account_name = azurerm_automation_account.automation_account[format("%s-automation-account", local.username)].name
  log_verbose             = "true"
  log_progress            = "true"
  runbook_type            = "PowerShell"

  publish_content_link {
    uri = "https://raw.githubusercontent.com/FortinetSecDevOps/technical-recipe-azure-fgt-automation-stitch/main/PowerShell/Update-RouteTable.ps1"
  }
}