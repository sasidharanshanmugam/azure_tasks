param privateEndpointName string = 'sql-pe'
param location string= 'East US'

// resource privateEndpoint 'Microsoft.Network/privateEndpoints@2021-05-01' = {
//   name: privateEndpointName
//   location: location
//   properties: {
//     subnet: {
//       id: '/subscriptions/d900cee5-fec6-4422-b897-6c283b48ac54/resourceGroups/Devopstraining1/providers/Microsoft.Network/virtualNetworks/BEvm-vnet/default'
//     }
//     privateLinkServiceConnections: [
//       {
//         name: privateEndpointName
//         properties: {
//           privateLinkServiceId: '/subscriptions/d900cee5-fec6-4422-b897-6c283b48ac54/resourceGroups/Devopstraining1/providers/Microsoft.Sql/servers/bo33nc7psd7bq'
//           groupIds: [
//             'sqlServer'
//           ]
//         }
//       }
//     ]
//   }
// }

resource privateEndpoint 'Microsoft.Network/privateEndpoints@2021-05-01' = {
  name: privateEndpointName
  location: location
  properties: {
    subnet: {
      id: '/subscriptions/d900cee5-fec6-4422-b897-6c283b48ac54/resourceGroups/Devopstraining1/providers/Microsoft.Network/virtualNetworks/BEvm-vnet/default'
      
    }
    privateLinkServiceConnections: [
      {
        name: privateEndpointName
        properties: {
          privateLinkServiceId: resourceId(
            'Microsoft.Sql/servers',
            'bo33nc7psd7bq',
            'Microsoft.Sql',
            'subid',
            'Devopstraining1'
          )
          groupIds: [
            'sqlServer'
          ]
        }
      }
    ]
  }
}


