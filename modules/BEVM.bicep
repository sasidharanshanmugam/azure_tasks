param location string ='westus3'
param adminUsername string='sasidharan'
@secure()
param adminPassword string
param sku string= '18.04-LTS'
param vmname string= 'BEUbuntuVM'
param bevm_nic_id string
resource ubuntuVM 'Microsoft.Compute/virtualMachines@2020-12-01' = {
  name: vmname
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B2s'
    }
    osProfile: {
      computerName: vmname
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: 'UbuntuServer'
        sku: sku
        version: 'latest'
      }
      osDisk: {
        name: 'name22'
        caching: 'ReadWrite'
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: bevm_nic_id
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
        // storageUri: 'storageUri'
      }
    }
  }
}
