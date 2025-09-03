@secure()
param adminPassword string

@secure()
param adminLogin string

@secure()
param sqlServerName string



resource daisy11db 'Microsoft.Sql/servers@2022-02-01-preview' = {
  kind: 'v12.0'
  properties: {
    administratorLogin: adminLogin
    administratorLoginPassword: adminPassword  // <-- include password here
    version: '12.0'
    state: 'Ready'
    fullyQualifiedDomainName: 'daisy11db.database.windows.net'
    privateEndpointConnections: []
    minimalTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: 'Disabled'
  }
  location: 'uksouth'
  tags: {}
  name: sqlServerName
}
