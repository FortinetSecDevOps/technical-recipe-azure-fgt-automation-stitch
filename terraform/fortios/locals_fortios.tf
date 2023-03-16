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

  system_automationstitches = {
    "routetableupdate-AppServers" = {
      name        = "routetableupdate-AppServers"
      description = "Update route table for App Servers"
      status      = "enable"
      trigger     = fortios_system_automationtrigger.system_automationtrigger["AppServer Existence"].name
      action_name = fortios_system_automationaction.system_automationaction.name
    }
    "routetableupdate-DbServers" = {
      name        = "routetableupdate-DbServers"
      description = "Update route table for Db Servers"
      status      = "enable"
      trigger     = fortios_system_automationtrigger.system_automationtrigger["DbServer Existence"].name
      action_name = fortios_system_automationaction.system_automationaction.name
    }
    "routetableupdate-WebServers" = {
      name        = "routetableupdate-WebServers"
      description = "Update route table for Web Servers"
      status      = "enable"
      trigger     = fortios_system_automationtrigger.system_automationtrigger["WebServer Existence"].name
      action_name = fortios_system_automationaction.system_automationaction.name
    }
  }
}