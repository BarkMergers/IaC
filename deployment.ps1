#$grp="TestBicep6"
#az group create --name $grp --location 'ukwest'
#az deployment group create --resource-group "TestBicep" --template-file .\script.bicep --mode Complete 
#$((Get-Random -Maximum 9999))

$rg = "newworldresourcegroup"
$location = "ukwest"
$functionApp = "newworldfunctionsapp"
$storageAccount = "mbnewworldstorage"

az group create --name $rg --location $location

#az configure --defaults group=$rg

az deployment group create `
  --resource-group $rg `
  --template-file .\functionApp.bicep `
  --parameters functionAppName=$functionApp storageAccountName=$storageAccount

  
#az deployment group create `
#  --resource-group $rg `
#  --template-file cosmos-mongo.bicep `
#  --parameters accountName=newworldmongo2
