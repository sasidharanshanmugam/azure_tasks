param location string = 'westus3'
param vnetname string ='Taskvnet1'
param appgw_subnet_name string= 'subnet1'
param appgw_subnet2_name string = 'subnet2'
resource virtualNetwork 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: vnetname
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: appgw_subnet_name 
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
      }
      {
        name: appgw_subnet2_name 
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
    ]
  }
}

output subnet1id string = virtualNetwork.properties.subnets[0].id
output subnet2id string = virtualNetwork.properties.subnets[1].id
output vnet1rsid string = virtualNetwork.id
output fevnet string = virtualNetwork.name
