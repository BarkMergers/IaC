resource daisy11db 'Microsoft.Sql/servers@2022-02-01-preview' = {
  kind: 'v12.0'
  properties: {
    administratorLogin: 'daisy11db'
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
  name: 'daisy11db'
}
