param networkInterfaceName string= 'demotasknic'
param location string=resourceGroup().location
param vm_subnet_id string
param networkSecurityGroupName string= 'demonic'
param publicIPAddressName string='taskazip'
resource networkInterface 'Microsoft.Network/networkInterfaces@2021-05-01' = {
  name: networkInterfaceName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: vm_subnet_id
          }
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddress.id
          }
        }
      }
    ]
    networkSecurityGroup: {
      id: networkSecurityGroup.id
    }
  }
}
// resource myNic 'Microsoft.Network/networkInterfaces@2021-08-01' = [for i in range(0, 2): {
//   name: '${}${(i + 1)}'
//   location: location
//   properties: {
//     ipConfigurations: [
//       {
//         name: '${ipconfig_name}${(i + 1)}'
//         properties: {
//           privateIPAllocationMethod: 'Dynamic'
//           publicIPAddress: {
//             id: publicIPAddress.id
//           }
//           subnet: {
//             id: vm_subnet_id
//           }
//           primary: true
//           privateIPAddressVersion: 'IPv4'
//           applicationGatewayBackendAddressPools: [
//             {
//               id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools', applicationGateways_myAppGateway_name, 'myBackendPool')
//             }
//           ]
//         }
//       }
//     ]
//     enableAcceleratedNetworking: false
//     enableIPForwarding: false
//     networkSecurityGroup: {
//       id: networkSecurityGroup.id
//     }
//   }
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
      {
        name: 'port80'
        properties: {
          priority: 1001
          protocol: 'Tcp'
          access: 'Allow'
          direction: 'Inbound'
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: '80'
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
      domainNameLabel: 'basicdemo234'
    }
    idleTimeoutInMinutes: 4
  }
}

output puplicipaddress string = publicIPAddress.id
output vmnic string = networkInterface.id
output fensgid string = networkSecurityGroup.id
output privateIpAddress string = networkInterface.properties.ipConfigurations[0].properties.privateIPAddress
