
$rg = "newworldresourcegroup"
$functionApp = "newworldfunctionsapp"
$storageAccount = "mbnewworldstorage"


# Create function app
$functionIPAddress = az deployment group create `
  --resource-group $rg `
  --template-file .\bicep\add-function-app.bicep `
  --parameters functionAppName=$functionApp storageAccountName=$storageAccount sqlConnectionString="$sqlConnString"


Write-Output The connection
Write-Output $functionIPAddress.properties.outputs.outboundIps.value


