resource mongorabbit4 'Microsoft.DocumentDB/mongoClusters@2023-03-01-preview' = {
  name: 'mongorabbit4'
  tags: {}
  location: 'francecentral'
  properties: {
    provisioningState: 'Succeeded'
    clusterStatus: 'Ready'
    administratorLogin: 'mymongorabbit'
    serverVersion: '8.0'
    nodeGroupSpecs: [
      {
        name: ''
        kind: 'Shard'
        sku: 'Free'
        diskSizeGB: 32
        enableHa: false
        nodeCount: 1
      }
    ]
    connectionString: 'mongodb+srv://<user>:<password>@mongorabbit4.mongocluster.cosmos.azure.com/?tls=true&authMechanism=SCRAM-SHA-256&retrywrites=false&maxIdleTimeMS=120000'
    earliestRestoreTime: '2025-08-24T11:09:41Z'
    privateEndpointConnections: []
    publicNetworkAccess: 'Enabled'
    replica: {
      role: 'Primary'
      replicationState: 'Active'
    }
    infrastructureVersion: '2.0'
  }
}
