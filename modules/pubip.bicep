param ip_name string= 'demo-ip-gw'
param location string= resourceGroup().location
// param tags string= 'Dev'
param dns_name string='sageipgw1234'
resource publicIP 'Microsoft.Network/publicIPAddresses@2020-06-01' = {
  name: ip_name
  location: location
  // tags: tags
  sku: {
    name: 'Standard'
  }
  properties:{
    publicIPAllocationMethod:'Static'
    dnsSettings:{
      domainNameLabel: dns_name
    }
  }
}

output ipResourceId string = publicIP.id
