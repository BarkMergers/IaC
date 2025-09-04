param sqlServerName string
param sqlDbName string
param functionAppName string
param location string

// Reference the Function App
resource functionApp 'Microsoft.Web/sites@2022-09-01' existing = {
  name: functionAppName
}

// Reference SQL Server
resource sqlServer 'Microsoft.Sql/servers@2022-02-01-preview' existing = {
  name: sqlServerName
}

// Loop over Function App outbound IPs and create firewall rules
var outboundIps = split(functionApp.properties.outboundIpAddresses, ',')

resource sqlFirewallRules 'Microsoft.Sql/servers/firewallRules@2022-02-01-preview' = [for ip in outboundIps: {
  name: '${sqlServer.name}-fw-${ip}'
  parent: sqlServer
  properties: {
    startIpAddress: ip
    endIpAddress: ip
  }
}]
