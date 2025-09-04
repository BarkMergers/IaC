$functionApp = "newworldfunctionsapp"
$storageAccount = "mbnewworldstorage"
$rg = "newworldresourcegroup"

# Create function app
az deployment group create `
  --resource-group $rg `
  --template-file .\init-database-firewall.bicep `
  --parameters functionAppName=$functionApp storageAccountName=$storageAccount