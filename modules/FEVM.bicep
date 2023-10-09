param location string ='westus3'
param adminUsername string='sasidharan'
@secure()
param adminPassword string
param sku string= '18.04-LTS'
param vm1nic string
param vmname string= 'simpleLinuxVM'
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
        name: 'name'
        caching: 'ReadWrite'
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: vm1nic
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
resource vmName_install_nginx 'Microsoft.Compute/virtualMachines/extensions@2020-06-01' = {
  parent: ubuntuVM
  name: 'install_nginx'
  location: location
  properties: {
    publisher: 'Microsoft.Azure.Extensions'
    type: 'CustomScript'
    typeHandlerVersion: '2.1'
    autoUpgradeMinorVersion: true
    settings: {
      skipDos2Unix: false
      fileUris: [
        'https://raw.githubusercontent.com/sasidharanshanmugam/azure_tasks/main/install-nginx.sh'
      ]
    }
    protectedSettings: {
      commandToExecute: 'sh install-nginx.sh'
    }
  }
}

output FEVMid string = ubuntuVM.id

