param fevnetname string
param bevnetname string
param location string = 'westus3'
param vnet1rsid string 
param bevnetrsid string
resource vnet1Peering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-11-01' = {
  name: '${fevnetname}/to-${bevnetname}'
  location: location
  properties: {
    remoteVirtualNetwork: {
      id: bevnetrsid
    }
    allowForwardedTraffic: false
    allowGatewayTransit: false
    useRemoteGateways: false
  }
}

resource vnet2Peering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-11-01' = {
  name: '${bevnetname}/to-${fevnetname}'
  location: location
  properties: {
    remoteVirtualNetwork: {
      id: vnet1rsid
    }
    allowForwardedTraffic: false
    allowGatewayTransit: false
    useRemoteGateways: false
  }
}
