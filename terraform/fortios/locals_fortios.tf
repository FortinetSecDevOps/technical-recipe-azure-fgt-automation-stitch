locals {
  firewall_addresses = {
    "AppServers" = {
      name   = "AppServers"
      type   = "dyanmic"
      sdn    = fortios_system_sdnconnector.system_sdnconnector.name
      filter = "Tag.ComputeType=AppServer"
    }
    "DbServers" = {
      name   = "DbServers"
      type   = "dyanmic"
      sdn    = fortios_system_sdnconnector.system_sdnconnector.name
      filter = "Tag.ComputeType=DbServer"
    }
    "WebServers" = {
      name   = "WebServers"
      type   = "dyanmic"
      sdn    = fortios_system_sdnconnector.system_sdnconnector.name
      filter = "Tag.ComputeType=WebServer"
    }
  }

  system_automationtriggers = {
    "AppServer Existence" = {
      name        = "AppServer Existence"
      description = "Tag ComputeType with value of AppServer updates route table."
      event_type  = "event-log"

      logid_blocks = [
        {
          id = 53200
        },
        {
          id = 53201
        }
      ]

      fields = [
        {
          name  = "cfgobj"
          value = "AppServers"
        }
      ]
    }
    "DbServer Existence" = {
      name        = "DbServer Existence"
      description = "Tag ComputeType with value of DbServer updates route table."
      event_type  = "event-log"

      logid_blocks = [
        {
          id = 53200
        },
        {
          id = 53201
        }
      ]

      fields = [
        {
          name  = "cfgobj"
          value = "DbServers"
        }
      ]
    }
    "WebServer Existence" = {
      name        = "WebServer Existence"
      description = "Tag ComputeType with value of WebServer updates route table."
      event_type  = "event-log"

      logid_blocks = [
        {
          id = 53200
        },
        {
          id = 53201
        }
      ]

      fields = [
        {
          name  = "cfgobj"
          value = "WebServers"
        }
      ]
    }
  }
}