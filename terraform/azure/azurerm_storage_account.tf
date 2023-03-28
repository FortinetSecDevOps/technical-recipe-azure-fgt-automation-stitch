resource "azurerm_storage_account" "storage_account" {
  for_each = local.storage_accounts

  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  name                     = format("%s%s", each.value.name, random_id.id.hex)
  account_replication_type = each.value.account_replication_type
  account_tier             = each.value.account_tier

  min_tls_version = each.value.min_tls_version
}
