@description('Cosmos DB account name, max length 44 characters, lowercase')
param accountName string = 'sql-${uniqueString(resourceGroup().id)}'


resource mongorabbit 'Microsoft.DocumentDB/mongoClusters@2023-03-01-preview' = {
  name: toLower(accountName)
  tags: {}
  location: 'uksouth'
  properties: {
    enableFreeTier: false
    //provisioningState: 'Succeeded'
    //clusterStatus: 'Ready'
    administratorLogin: 'mymongorabbit'
    serverVersion: '8.0'
    nodeGroupSpecs: [
      {
        name: ''
        kind: 'Shard'
        sku: 'Free'
        /*sku: {
          name: 'Standard_D2s_v3'   // SKU name
          tier: 'Standard'           // Tier
          capacity: 1                // Number of vCores
        }*/
        //sku: 'Standard_D2s_v3'
        diskSizeGB: 32
        enableHa: false
        nodeCount: 1
      }
    ]
    administratorLoginPassword: 'abc123pFDi4$'
    //connectionString: 'mongodb+srv://<user>:<password>@mongorabbit.mongocluster.cosmos.azure.com/?tls=true&authMechanism=SCRAM-SHA-256&retrywrites=false&maxIdleTimeMS=120000'
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



output mongoConnectionString string = mongorabbit.properties.connectionStrings[0].connectionString



/*




@description('Location for the Cosmos DB account.')
param location string = resourceGroup().location

@description('The primary region for the Cosmos DB account.')
param primaryRegion string

@description('The secondary region for the Cosmos DB account.')
param secondaryRegion string

@description('The default consistency level of the Cosmos DB account.')
@allowed([
  'Eventual'
  'ConsistentPrefix'
  'Session'
  'BoundedStaleness'
  'Strong'
])
param defaultConsistencyLevel string = 'Session'

@description('Max stale requests. Required for BoundedStaleness. Valid ranges, Single Region: 10 to 2147483647. Multi Region: 100000 to 2147483647.')
@minValue(10)
@maxValue(2147483647)
param maxStalenessPrefix int = 100000

@description('Max lag time (minutes). Required for BoundedStaleness. Valid ranges, Single Region: 5 to 84600. Multi Region: 300 to 86400.')
@minValue(5)
@maxValue(86400)
param maxIntervalInSeconds int = 300

@description('Enable system managed failover for regions')
param systemManagedFailover bool = true

@description('The name for the database')
param databaseName string

@description('The name for the container')
param containerName string

@description('Maximum autoscale throughput for the container')
@minValue(1000)
@maxValue(1000000)
param autoscaleMaxThroughput int = 1000

var consistencyPolicy = {
  Eventual: {
    defaultConsistencyLevel: 'Eventual'
  }
  ConsistentPrefix: {
    defaultConsistencyLevel: 'ConsistentPrefix'
  }
  Session: {
    defaultConsistencyLevel: 'Session'
  }
  BoundedStaleness: {
    defaultConsistencyLevel: 'BoundedStaleness'
    maxStalenessPrefix: maxStalenessPrefix
    maxIntervalInSeconds: maxIntervalInSeconds
  }
  Strong: {
    defaultConsistencyLevel: 'Strong'
  }
}
var locations = [
  {
    locationName: primaryRegion
    failoverPriority: 0
    isZoneRedundant: false
  }
  {
    locationName: secondaryRegion
    failoverPriority: 1
    isZoneRedundant: false
  }
]

resource account 'Microsoft.DocumentDB/databaseAccounts@2022-05-15' = {
  name: toLower(accountName)
  kind: 'GlobalDocumentDB'
  location: location
  properties: {
    consistencyPolicy: consistencyPolicy[defaultConsistencyLevel]
    locations: locations
    databaseAccountOfferType: 'Standard'
    enableAutomaticFailover: systemManagedFailover
  }
}

resource database 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2022-05-15' = {
  parent: account
  name: databaseName
  properties: {
    resource: {
      id: databaseName
    }
  }
}

resource container 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2022-05-15' = {
  parent: database
  name: containerName
  properties: {
    resource: {
      id: containerName
      partitionKey: {
        paths: [
          '/myPartitionKey'
        ]
        kind: 'Hash'
      }
      indexingPolicy: {
        indexingMode: 'consistent'
        includedPaths: [
          {
            path: '/*'
          }
        ]
        excludedPaths: [
          {
            path: '/myPathToNotIndex/*'
          }
          {
            path: '/_etag/?'
          }
        ]
        compositeIndexes: [
          [
            {
              path: '/name'
              order: 'ascending'
            }
            {
              path: '/age'
              order: 'descending'
            }
          ]
        ]
        spatialIndexes: [
          {
            path: '/path/to/geojson/property/?'
            types: [
              'Point'
              'Polygon'
              'MultiPolygon'
              'LineString'
            ]
          }
        ]
      }
      defaultTtl: 86400
      uniqueKeyPolicy: {
        uniqueKeys: [
          {
            paths: [
              '/phoneNumber'
            ]
          }
        ]
      }
    }
    options: {
      autoscaleSettings: {
        maxThroughput: autoscaleMaxThroughput
      }
    }
  }
}


*/
