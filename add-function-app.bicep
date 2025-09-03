@description('Name of the Function App')
param functionAppName string

@description('Name of the Resource Group location')
param location string = resourceGroup().location

@description('Name of the hosting plan (App Service Plan)')
param hostingPlanName string = 'myPlan'

@description('Name of the storage account')
param storageAccountName string

param sqlConnectionString string



param allowedOrigins array = [
  'http://localhost:59414'
  'https://www.admin.nice-beach-erikson.autos'
  'https://www.company1.nice-beach-erikson.autos'
  'https://thankful-pebble-01e32d81e.1.azurestaticapps.net'
]



// Storage account for Function App
resource storage 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2' // recomended for all situtations unless you really need the old storage
}



// App Service Plan (Consumption Plan for Functions)
resource hostingPlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: hostingPlanName
  location: location
  sku: {
    name: 'Y1'
    tier: 'Dynamic'
  }
}




// Function App
// This version is the hand-built version I have made


resource functionApp 'Microsoft.Web/sites@2024-11-01' = {
  name: functionAppName
  location: location
  kind: 'functionapp'
  properties: {
    serverFarmId: hostingPlan.id
    siteConfig: {

      // Use the allowed origins array to set up CORS
      cors: {
        allowedOrigins: allowedOrigins
        supportCredentials: true
      }



      appSettings: [
        {
          name: 'AzureWebJobsStorage'
          value: storage.properties.primaryEndpoints.blob
        }
        {
          name:'RedisConnection'
          value:'MyAzureRedis.redis.cache.windows.net:6380,password=lnA7fbrgZm3NLApKILzsOHFw0KRejE8tzAzCaN8QrtM=,ssl=True,abortConnect=False'
        }
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~4'
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'dotnet' // Change to node, python, java if needed
        }
        {
          name: 'ArchiveDatabase'
          value: 'Server=0.tcp.eu.ngrok.io,18881;Database=linktest;User Id=linktest;Password=sada434RFd2;TrustServerCertificate=True;'
        }
        {
          name: 'NewSQLConnection'
          value: sqlConnectionString
        }
        {
          name: 'NewWorldDatabase'
          value: 'Server=tcp:daisy11db.database.windows.net,1433;Initial Catalog=myrabbit1;Persist Security Info=False;User ID=daisy11db;Password=my!n3wpa55word321;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;'
        }
        {
          name: 'TENANT_ID'
          value: '3fdf479e-e456-4ae5-9431-657da2d108ec'
        }
        {
          name: 'BACKEND_CLIENT_ID'
          value: '6be0af57-8832-4ef2-adc4-060e2067bcf6'
        }
      ]
    }
  }
}





// Function App
/* This version is made by taking the JSON from Azure Portal, adding the wrapper: 
    {
      "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
      "contentVersion": "1.0.0.0",
      "resources": [
        ***** JSON GOES HERE *****
      ]
    }
  and then running it through 'az bicep decompile --file <filename>.json'
  It throws lots of warnings but these read-only values seem to get ignored and the process runs fine
*/



/*
resource newworldfunctionsapp 'Microsoft.Web/sites@2022-03-01' = {
  name: 'newworldfunctionsapp'
  kind: 'functionapp'
  location: 'UK West'
  properties: {
    name: 'newworldfunctionsapp'
    state: 'Running'
    hostNames: [
      'newworldfunctionsapp.azurewebsites.net'
    ]
    webSpace: 'newworldresourcegroup-UKWestwebspace'
    selfLink: 'https://waws-prod-cw1-035.api.azurewebsites.windows.net:454/subscriptions/b9144b57-a2c0-4fe8-80ab-10fe51d32287/webspaces/newworldresourcegroup-UKWestwebspace/sites/newworldfunctionsapp'
    repositorySiteName: 'newworldfunctionsapp'
    owner: null
    usageState: 'Normal'
    enabled: true
    adminEnabled: true
    siteScopedCertificatesEnabled: false
    afdEnabled: false
    enabledHostNames: [
      'newworldfunctionsapp.azurewebsites.net'
      'newworldfunctionsapp.scm.azurewebsites.net'
    ]
    siteProperties: {
      metadata: null
      properties: [
        {
          name: 'LinuxFxVersion'
          value: ''
        }
        {
          name: 'WindowsFxVersion'
          value: null
        }
      ]
      appSettings: null
    }
    availabilityState: 'Normal'
    sslCertificates: null
    csrs: []
    cers: null
    siteMode: null
    hostNameSslStates: [
      {
        name: 'newworldfunctionsapp.azurewebsites.net'
        sslState: 'Disabled'
        ipBasedSslResult: null
        virtualIP: null
        virtualIPv6: null
        thumbprint: null
        certificateResourceId: null
        toUpdate: null
        toUpdateIpBasedSsl: null
        ipBasedSslState: 'NotConfigured'
        hostType: 'Standard'
      }
      {
        name: 'newworldfunctionsapp.scm.azurewebsites.net'
        sslState: 'Disabled'
        ipBasedSslResult: null
        virtualIP: null
        virtualIPv6: null
        thumbprint: null
        certificateResourceId: null
        toUpdate: null
        toUpdateIpBasedSsl: null
        ipBasedSslState: 'NotConfigured'
        hostType: 'Repository'
      }
    ]
    computeMode: null
    serverFarm: null
    serverFarmId: '/subscriptions/b9144b57-a2c0-4fe8-80ab-10fe51d32287/resourceGroups/newworldresourcegroup/providers/Microsoft.Web/serverfarms/myPlan'
    reserved: false
    isXenon: false
    hyperV: false
    sandboxType: null
    lastModifiedTimeUtc: '2025-09-03T12:29:50.92'
    storageRecoveryDefaultState: 'Running'
    contentAvailabilityState: 'Normal'
    runtimeAvailabilityState: 'Normal'
    dnsConfiguration: {}
    vnetRouteAllEnabled: false
    containerAllocationSubnet: null
    useContainerLocalhostBindings: null
    vnetImagePullEnabled: false
    vnetContentShareEnabled: false
    siteConfig: {
      numberOfWorkers: 1
      defaultDocuments: null
      netFrameworkVersion: null
      phpVersion: null
      pythonVersion: null
      nodeVersion: null
      powerShellVersion: null
      linuxFxVersion: ''
      windowsFxVersion: null
      sandboxType: null
      windowsConfiguredStacks: null
      requestTracingEnabled: null
      remoteDebuggingEnabled: null
      remoteDebuggingVersion: null
      httpLoggingEnabled: null
      azureMonitorLogCategories: null
      acrUseManagedIdentityCreds: false
      acrUserManagedIdentityID: null
      logsDirectorySizeLimit: null
      detailedErrorLoggingEnabled: null
      publishingUsername: null
      publishingPassword: null
      appSettings: null
      metadata: null
      connectionStrings: null
      machineKey: null
      handlerMappings: null
      documentRoot: null
      scmType: null
      use32BitWorkerProcess: null
      webSocketsEnabled: null
      alwaysOn: false
      javaVersion: null
      javaContainer: null
      javaContainerVersion: null
      appCommandLine: null
      managedPipelineMode: null
      virtualApplications: null
      winAuthAdminState: null
      winAuthTenantState: null
      customAppPoolIdentityAdminState: null
      customAppPoolIdentityTenantState: null
      runtimeADUser: null
      runtimeADUserPassword: null
      loadBalancing: null
      routingRules: null
      experiments: null
      limits: null
      autoHealEnabled: null
      autoHealRules: null
      tracingOptions: null
      vnetName: null
      vnetRouteAllEnabled: null
      vnetPrivatePortsCount: null
      publicNetworkAccess: null
      cors: null
      push: null
      apiDefinition: null
      apiManagementConfig: null
      autoSwapSlotName: null
      localMySqlEnabled: null
      managedServiceIdentityId: null
      xManagedServiceIdentityId: null
      keyVaultReferenceIdentity: null
      ipSecurityRestrictions: null
      ipSecurityRestrictionsDefaultAction: null
      scmIpSecurityRestrictions: null
      scmIpSecurityRestrictionsDefaultAction: null
      scmIpSecurityRestrictionsUseMain: null
      http20Enabled: false
      minTlsVersion: null
      minTlsCipherSuite: null
      scmMinTlsCipherSuite: null
      supportedTlsCipherSuites: null
      scmSupportedTlsCipherSuites: null
      scmMinTlsVersion: null
      ftpsState: null
      preWarmedInstanceCount: null
      functionAppScaleLimit: 200
      elasticWebAppScaleLimit: null
      healthCheckPath: null
      fileChangeAuditEnabled: null
      functionsRuntimeScaleMonitoringEnabled: null
      websiteTimeZone: null
      minimumElasticInstanceCount: 1
      azureStorageAccounts: null
      http20ProxyFlag: null
      sitePort: null
      antivirusScanEnabled: null
      storageType: null
      sitePrivateLinkHostEnabled: null
      clusteringEnabled: false
    }
    functionAppConfig: null
    daprConfig: null
    deploymentId: 'newworldfunctionsapp'
    slotName: null
    trafficManagerHostNames: null
    sku: 'Dynamic'
    scmSiteAlsoStopped: false
    targetSwapSlot: null
    hostingEnvironment: null
    hostingEnvironmentProfile: null
    clientAffinityEnabled: false
    clientAffinityProxyEnabled: false
    useQueryStringAffinity: false
    blockPathTraversal: false
    clientCertEnabled: false
    clientCertMode: 'Required'
    clientCertExclusionPaths: null
    clientCertExclusionEndPoints: null
    hostNamesDisabled: false
    ipMode: 'IPv4'
    vnetBackupRestoreEnabled: false
    domainVerificationIdentifiers: null
    customDomainVerificationId: 'E0F445A2203967F477B6A41FF99BA6ED8C308518BE94AC42149990895F2C7B16'
    kind: 'functionapp'
    managedEnvironmentId: null
    workloadProfileName: null
    resourceConfig: null
    inboundIpAddress: '51.140.210.106'
    possibleInboundIpAddresses: '51.140.210.106'
    inboundIpv6Address: '2603:1020:605:402::aa'
    possibleInboundIpv6Addresses: '2603:1020:605:402::aa'
    ftpUsername: 'newworldfunctionsapp\\$newworldfunctionsapp'
    ftpsHostName: 'ftps://waws-prod-cw1-035.ftp.azurewebsites.windows.net/site/wwwroot'
    outboundIpAddresses: '20.162.96.133,20.162.96.139,20.162.102.14,20.162.102.19,20.162.102.25,20.162.96.216,51.141.93.130,51.141.77.220,51.141.83.1,51.141.83.36,51.141.91.183,51.141.73.71,51.141.73.124,51.141.84.205,51.141.84.107,51.141.91.173,51.141.78.46,51.141.78.2,51.140.210.106'
    possibleOutboundIpAddresses: '20.162.96.133,20.162.96.139,20.162.102.14,20.162.102.19,20.162.102.25,20.162.96.216,51.141.93.130,51.141.77.220,51.141.83.1,51.141.83.36,51.141.91.183,51.141.73.71,51.141.73.124,51.141.84.205,51.141.84.107,51.141.91.173,51.141.78.46,51.141.78.2,20.162.113.14,20.162.97.1,20.162.96.201,20.162.97.46,20.162.102.62,51.141.95.228,51.141.93.234,51.141.89.204,51.141.89.211,51.141.87.228,51.141.84.35,51.141.85.209,51.141.84.201,51.141.84.209,51.141.76.185,51.141.89.153,51.141.82.238,51.141.80.127,51.141.87.140,51.141.78.13,51.141.78.32,51.141.84.196,51.141.90.215,51.141.90.234,51.141.74.63,51.140.210.106'
    outboundIpv6Addresses: '2603:1020:600:7::332,2603:1020:600:8::2c7,2603:1020:600::678,2603:1020:600:8::2cc,2603:1020:600:9::1f6,2603:1020:600:9::1f7,2603:1020:600::694,2603:1020:600:8::2ec,2603:1020:600::696,2603:1020:600:7::355,2603:1020:600::69a,2603:1020:600::69d,2603:1020:600:8::2f3,2603:1020:600:8::2f5,2603:1020:600:8::2f8,2603:1020:600::6a0,2603:1020:600:8::2f9,2603:1020:600:8::2fa,2603:1020:605:402::aa,2603:10e1:100:2::338c:d26a'
    possibleOutboundIpv6Addresses: '2603:1020:600:7::332,2603:1020:600:8::2c7,2603:1020:600::678,2603:1020:600:8::2cc,2603:1020:600:9::1f6,2603:1020:600:9::1f7,2603:1020:600::694,2603:1020:600:8::2ec,2603:1020:600::696,2603:1020:600:7::355,2603:1020:600::69a,2603:1020:600::69d,2603:1020:600:8::2f3,2603:1020:600:8::2f5,2603:1020:600:8::2f8,2603:1020:600::6a0,2603:1020:600:8::2f9,2603:1020:600:8::2fa,2603:1020:600:8::2d0,2603:1020:600:8::2d3,2603:1020:600:8::2d4,2603:1020:600:7::33d,2603:1020:600:8::2d7,2603:1020:600:7::340,2603:1020:600::685,2603:1020:600:7::344,2603:1020:600::688,2603:1020:600:7::34a,2603:1020:600:8::2dc,2603:1020:600::68c,2603:1020:600:8::2df,2603:1020:600:8::2e0,2603:1020:600::691,2603:1020:600::692,2603:1020:600:7::351,2603:1020:600:7::354,2603:1020:600:7::35e,2603:1020:600::6a3,2603:1020:600::6a4,2603:1020:600:8::2fd,2603:1020:600:7::360,2603:1020:600:7::362,2603:1020:605:402::aa,2603:10e1:100:2::338c:d26a'
    containerSize: 1536
    dailyMemoryTimeQuota: 0
    suspendedTill: null
    siteDisabledReason: 0
    functionExecutionUnitsCache: null
    maxNumberOfWorkers: null
    homeStamp: 'waws-prod-cw1-035'
    cloningInfo: null
    hostingEnvironmentId: null
    tags: null
    resourceGroup: 'newworldresourcegroup'
    defaultHostName: 'newworldfunctionsapp.azurewebsites.net'
    slotSwapStatus: null
    httpsOnly: false
    endToEndEncryptionEnabled: false
    functionsRuntimeAdminIsolationEnabled: false
    redundancyMode: 'None'
    inProgressOperationId: null
    geoDistributions: null
    privateEndpointConnections: []
    publicNetworkAccess: null
    buildVersion: null
    targetBuildVersion: null
    migrationState: null
    eligibleLogCategories: 'FunctionAppLogs,AppServiceAuthenticationLogs'
    inFlightFeatures: [
      'SiteContainers'
    ]
    storageAccountRequired: false
    virtualNetworkSubnetId: null
    keyVaultReferenceIdentity: 'SystemAssigned'
    autoGeneratedDomainNameLabelScope: null
    privateLinkIdentifiers: null
    sshEnabled: null
  }
}



*/
