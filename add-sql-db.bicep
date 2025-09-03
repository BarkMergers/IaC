@secure()
param adminPassword string

param sqlServerName string
param sqlDatabaseName string
param adminLogin string


resource myrabbit1_a 'Microsoft.Sql/servers/databases@2022-11-01-preview' = {
  sku: {
    name: 'GP_S_Gen5'
    tier: 'GeneralPurpose'
    family: 'Gen5'
    capacity: 2
  }
  kind: 'v12.0,user,vcore,serverless,freelimit'
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    maxSizeBytes: 34359738368


    currentServiceObjectiveName: 'GP_S_Gen5_2'
    requestedServiceObjectiveName: 'GP_S_Gen5_2'
    defaultSecondaryLocation: 'ukwest'
    catalogCollation: 'SQL_Latin1_General_CP1_CI_AS'
    zoneRedundant: false

    readScale: 'Disabled'

    autoPauseDelay: 60
    requestedBackupStorageRedundancy: 'Local'
    minCapacity: json('0.5')
    maintenanceConfigurationId: '/subscriptions/b9144b57-a2c0-4fe8-80ab-10fe51d32287/providers/Microsoft.Maintenance/publicMaintenanceConfigurations/SQL_Default'
    isLedgerOn: false
    useFreeLimit: true
    freeLimitExhaustionBehavior: 'AutoPause'
    availabilityZone: 'NoPreference'
  }
  location: 'uksouth'
  tags: {}
  name: '${sqlServerName}/${sqlDatabaseName}'
}


// Output the connection string
output sqlConnectionString string = 'Server=tcp:${sqlServerName}.database.windows.net,1433;Initial Catalog=${sqlDatabaseName};Persist Security Info=False;User ID=${adminLogin};Password=${adminPassword};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;'

