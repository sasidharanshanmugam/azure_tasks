param location string =resourceGroup().location
// param capacity int = 0
param appgw_public_ip string
param appgw_subnet_id string
param applicationGateWayName string = 'dev-demoappgw'
// param target_vm_id   string
// param appgw_nsg_id string
// param appgwnic_sub_id string
// param appgwnicname string
param fevmip string

resource applicationGateWay 'Microsoft.Network/applicationGateways@2021-05-01' = {
  name: applicationGateWayName
  location: location
  properties: {
    sku: {
      name: 'Standard_v2'
      tier: 'Standard_v2'
    }
    gatewayIPConfigurations: [
      {
        name: 'appGatewayIpConfig'
        properties: {
          subnet: {
            id: appgw_subnet_id
          }
        }
      }
    ]
    frontendIPConfigurations: [
      {
        name: 'appGwPublicFrontendIp'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: appgw_public_ip
          }
        }
      }
    ]
    frontendPorts: [
      {
        name: 'port_80'
        properties: {
          port: 80
        }
      }
    ]
    backendAddressPools: [
      {
        name: 'myBackendPool'
        properties: {
          backendAddresses: [
            {
              // fqdn: 'string'
               ipAddress: fevmip
            }
          ]
        }
      }
    ]
    backendHttpSettingsCollection: [
      {
        name: 'myHTTPSetting'
        properties: {
          port: 80
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
          pickHostNameFromBackendAddress: false
          requestTimeout: 20
        }
      }
    ]
    httpListeners: [
      {
        name: 'myListener'
        properties: {
          frontendIPConfiguration: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendIPConfigurations', applicationGateWayName, 'appGwPublicFrontendIp')
          }
          frontendPort: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendPorts', applicationGateWayName, 'port_80')
          }
          protocol: 'Http'
          requireServerNameIndication: false
        }
      }
    ]
    requestRoutingRules: [
      {
        name: 'myRoutingRule'
        properties: {
          ruleType: 'Basic'
          httpListener: {
            id: resourceId('Microsoft.Network/applicationGateways/httpListeners', applicationGateWayName, 'myListener')
          }
          backendAddressPool: {
            id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools', applicationGateWayName, 'myBackendPool')
          }
          backendHttpSettings: {
            id: resourceId('Microsoft.Network/applicationGateways/backendHttpSettingsCollection', applicationGateWayName, 'myHTTPSetting')
          }
        }
      }
    ]
    enableHttp2: false
    autoscaleConfiguration: {
      minCapacity: 0
      maxCapacity: 10
    }
  }
}

// resource networkInterface 'Microsoft.Network/networkInterfaces@2021-05-01' = {
//   name: appgwnicname 
//   location: location
//   properties: {
//     ipConfigurations: [
//       {
//         name: 'ipconfig1'
//         properties: {
//           privateIPAllocationMethod: 'Dynamic'
//           publicIPAddress: {
//             id: appgw_public_ip
//           }
//           subnet: {
//             id: appgwnic_sub_id
//           }
//           primary: true
//           privateIPAddressVersion: 'IPv4'
//           applicationGatewayBackendAddressPools: [
//             {
//               id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools', applicationGateWayName, 'myBackendPool')
//             }
//           ]
//         }
//       }
//     ]
//     enableAcceleratedNetworking: false
//     enableIPForwarding: false
//     networkSecurityGroup: {
//       id: appgw_nsg_id
//     }
//   }
//   dependsOn: [
//     applicationGateWay
//   ]
// }
// param location string = resourceGroup().location
// param appgw_nsg_id string
// param appgw_public_ip string
// param appgw_subnet_id string
// param appgwnic_sub_id string
// param appgwnicname string
// param fevmip string

// resource applicationGateWay 'Microsoft.Network/applicationGateways@2021-05-01' = {
//   name: 'dev-demoappgw'
//   location: location
//   properties: {
//     sku: {
//       name: 'Standard_v2'
//       tier: 'Standard_v2'
//     }
//     gatewayIPConfigurations: [
//       {
//         name: 'appGatewayIpConfig'
//         properties: {
//           subnet: {
//             id: appgw_subnet_id
//           }
//         }
//       }
//     ]
//     frontendIPConfigurations: [
//       {
//         name: 'appGwPublicFrontendIp'
//         properties: {
//           privateIPAllocationMethod: 'Dynamic'
//           publicIPAddress: {
//             id: appgw_public_ip
//           }
//         }
//       }
//     ]
//     frontendPorts: [
//       {
//         name: 'port_80'
//         properties: {
//           port: 80
//         }
//       }
//     ]
//     backendAddressPools: [
//       {
//         name: 'myBackendPool01'
//         properties: {
//           backendAddresses: [
//             {
//               ipAddress: fevmip
//             }
//           ]
//         }
//       }
//     ]
//     backendHttpSettingsCollection: [
//       {
//         name: 'myHTTPSetting'
//         properties: {
//           port: 80
//           protocol: 'Http'
//           cookieBasedAffinity: 'Disabled'
//           pickHostNameFromBackendAddress: false
//           requestTimeout: 20
//         }
//       }
//     ]
//     httpListeners: [
//       {
//         name: 'myListener'
//         properties: {
//           frontendIPConfiguration: {
//             id: resourceId('Microsoft.Network/applicationGateways/frontendIPConfigurations', 'dev-demoappgw', 'appGwPublicFrontendIp')
//           }
//           frontendPort: {
//             id: resourceId('Microsoft.Network/applicationGateways/frontendPorts', 'dev-demoappgw', 'port_80')
//           }
//           protocol: 'Http'
//           requireServerNameIndication: false
//         }
//       }
//     ]
//     requestRoutingRules: [
//       {
//         name: 'myRoutingRule'
//         properties: {
//           ruleType: 'Basic'
//           httpListener: {
//             id: resourceId('Microsoft.Network/applicationGateways/httpListeners', 'dev-demoappgw', 'myListener')
//           }
//           backendAddressPool: {
//             id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools', 'dev-demoappgw', 'myBackendPool')
//           }
//           backendHttpSettings: {
//             id: resourceId('Microsoft.Network/applicationGateways/backendHttpSettingsCollection', 'dev-demoappgw', 'myHTTPSetting')
//           }
//         }
//       }
//     ]
//     enableHttp2: false
//     autoscaleConfiguration: {
//       minCapacity: 0
//       maxCapacity: 10
//     }
//   }
// }

// resource networkInterface 'Microsoft.Network/networkInterfaces@2021-05-01' = {
//   name: appgwnicname 
//   location: location
//   properties: {
//     ipConfigurations: [
//       {
//         name: 'ipconfig1'
//         properties: {
//           privateIPAllocationMethod: 'Dynamic'
//           publicIPAddress: {
//             id: appgw_public_ip
//           }
//           subnet: {
//             id: appgwnic_sub_id
//           }
//           primary: true
//           privateIPAddressVersion: 'IPv4'
//           applicationGatewayBackendAddressPools: [
//             {
//               id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools', 'dev-demoappgw', 'myBackendPool')
//             }
//           ]
//         }
//       }
//     ]
//     enableAcceleratedNetworking: false
//     enableIPForwarding: false
//     networkSecurityGroup: {
//       id: appgw_nsg_id
//     }
//   }
//   dependsOn: [
//     applicationGateWay
//   ]
// }
