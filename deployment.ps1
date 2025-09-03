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







# Create an SQL server
az deployment group create `
  --resource-group $rg `
  --template-file .\add-sql-server.bicep `
  --parameters sqlServerName=newworld00112231 adminLogin=sqladmin adminPassword='MyS3cur3P@ssword!'

# Create a new Database
$sqlConnString = az deployment group create `
  --resource-group $rg `
  --template-file .\add-sql-db.bicep `
  --parameters sqlServerName=newworld00112231 adminLogin=sqladmin sqlDatabaseName='Rabbit3' adminPassword='MyS3cur3P@ssword!' `
  --query "properties.outputs.sqlConnectionString.value" -o tsv

# Create function app
az deployment group create `
  --resource-group $rg `
  --template-file .\add-function-app.bicep `
  --parameters functionAppName=$functionApp storageAccountName=$storageAccount sqlConnectionString="$sqlConnString"


  
# 
#az deployment group create `
#  --resource-group $rg `
#  --template-file cosmos-mongo.bicep `
#  --parameters accountName=mongorabbit4 `
#  --query properties.outputs
#