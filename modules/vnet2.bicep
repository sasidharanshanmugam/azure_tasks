param location string = 'westus3'
param vnetname string ='Taskvnet2'
param subnetname1 string ='Subnet-1'
param subnetname2 string ='Subnet-2'
resource virtualNetwork 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: vnetname
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '172.1.0.0/16'
      ]
    }
    subnets: [
      {
        name: subnetname1
        properties: {
          addressPrefix: '172.1.2.0/24'
          privateEndpointNetworkPolicies: 'Disabled'
        }
      }
      {
        name: subnetname2
        properties: {
          addressPrefix: '172.1.21.0/24'
        }
      }
    ]
  }
}
output besubnetnameid string = virtualNetwork.properties.subnets[0].id
output besubnet2id string = virtualNetwork.properties.subnets[1].id
output vnet2rsid string = virtualNetwork.id
output bevnetname string = virtualNetwork.name
