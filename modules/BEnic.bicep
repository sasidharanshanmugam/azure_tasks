param networkInterfaceName string= 'demotasknic-be'
param location string=resourceGroup().location
param bevm_subnet_id string
param networkSecurityGroupName string= 'demonsg'
param publicIPAddressName string='taskaz-ip2'
resource networkInterface 'Microsoft.Network/networkInterfaces@2021-05-01' = {
  name: networkInterfaceName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: bevm_subnet_id
          }
          privateIPAllocationMethod: 'Dynamic'
          // publicIPAddress: {
          //   id: publicIPAddress.id
          // }
        }
      }
    ]
    networkSecurityGroup: {
      id: networkSecurityGroup.id
    }
  }
}

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2021-05-01' = {
  name: networkSecurityGroupName
  location: location
  properties: {
    securityRules: [
      {
        name: 'SSH'
        properties: {
          priority: 1000
          protocol: 'Tcp'
          access: 'Allow'
          direction: 'Inbound'
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: '22'
        }
      }
    ]
  }
}
resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2021-05-01' = {
  name: publicIPAddressName
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
    publicIPAddressVersion: 'IPv4'
    dnsSettings: {
      domainNameLabel: 'basicdemo1998'
    }
    idleTimeoutInMinutes: 4
  }
}
// resource disassociatePublicIp 'Microsoft.Network/networkInterfaces/ipConfigurations@2020-11-01' = {
//   parent: networkInterface
//   name: 'ipconfig1'
//   properties: {
//     publicIPAddress: null
//   }
// }

output puplicipaddress string = publicIPAddress.id
output bevmnic string = networkInterface.id
output publicIpAddressOutput string = publicIPAddress.properties.ipAddress

