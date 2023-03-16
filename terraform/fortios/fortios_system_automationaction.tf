locals {
  http_headers = [
    {
      key   = "ResourceGroupName"
      value = var.resource_group_name
    },
    {
      key   = "RouteTableName"
      value = var.route_table_name
    },
    {
      key   = "RouteNamePrefix"
      value = "microseg"
    },
    {
      key   = "NextHopIp"
      value = var.next_hop_ip
    },
  ]
}
resource "fortios_system_automationaction" "system_automationaction" {

  name        = "routetableupdate"
  description = "Update Route Table for MicroSegmentation"
  action_type = "webhook"
  protocol    = "https"

  uri       = var.webhook
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