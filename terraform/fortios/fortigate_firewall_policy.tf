resource "fortios_firewall_policy" "firewall_policy" {

  action     = "accept"
  logtraffic = "utm"
  nat        = "disable"
  status     = "enable"
  schedule   = "always"

  name = "webser2webserver"
  srcintf {
    name = "port2"
  }

  dstintf {
    name = "port2"
  }
  srcaddr {
    name = fortios_firewall_address.firewall_address["WebServers"].name
  }

  dstaddr {
    name = fortios_firewall_address.firewall_address["WebServers"].name
  }

  service {
    name = "ALL"
  }
}
