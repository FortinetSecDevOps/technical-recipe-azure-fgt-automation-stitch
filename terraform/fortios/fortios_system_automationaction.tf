locals {
  http_headers = [
    {
      key   = "ResourceGroupName"
      value = "rg-name"
    },
    {
      key   = "RouteTableName"
      value = "route-table-name"
    },
    {
      key   = "RouteNamePrefix"
      value = "route-name-prefix"
    },
    {
      key   = "NextHopIp"
      value = "next-hop-ip"
    },
  ]
}
resource "fortios_system_automationaction" "system_automationaction" {

  name        = "routetableupdate"
  description = "Update Route Table for MicroSegmentation"
  action_type = "webhook"
  protocol    = "https"

  uri       = "your-webhook-to-azure-automation-runbook"
  http_body = "{\"action\":\"%%log.action%%\", \"addr\":\"%%log.addr%%\"}"
  port      = 443

  dynamic "http_headers" {
    for_each = local.http_headers

    content {
      key   = http_headers.value.key
      value = http_headers.value.value
    }
  }

  verify_host_cert = "disable"
}