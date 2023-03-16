resource "fortios_system_sdnconnector" "system_sdnconnector" {
  name = "AzureSDN"

  azure_region     = "global"
  status           = "enable"
  type             = "azure"
  update_interval  = 60
  use_metadata_iam = "enable"
  subscription_id  = ""
  resource_group   = ""
}