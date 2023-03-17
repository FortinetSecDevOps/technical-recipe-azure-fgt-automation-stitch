resource "fortios_router_static" "router_static" {

  device  = "port2"
  dst     = "10.1.2.0/24"
  gateway = "10.1.1.1"
  status  = "enable"

}