resource "azurerm_automation_runbook" "automation_runbook" {

  resource_group_name = azurerm_resource_group.resource_group[0].name
  location            = azurerm_resource_group.resource_group[0].location

  name                    = "Update-RouteTable"
  automation_account_name = azurerm_automation_account.automation_account.name
  log_verbose             = "true"
  log_progress            = "true"
  runbook_type            = "PowerShell"

  publish_content_link {
    uri = "https://raw.githubusercontent.com/FortinetSecDevOps/technical-recipe-azure-fgt-automation-stitch/main/PowerShell/Update-RouteTable.ps1"
  }
}