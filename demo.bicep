resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: 'storage1998st'
  location: 'westus3'
  kind: 'StorageV2'
  sku: {
    name: 'Premium_LRS'
  }
  properties:{
    accessTier : 'Hot'
  }
}

