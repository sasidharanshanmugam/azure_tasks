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
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: subnetname1
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
      }
      {
        name: subnetname2
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
    ]
  }
}
output result string = virtualNetwork.name
