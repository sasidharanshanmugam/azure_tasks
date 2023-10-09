param location string = 'westus3'
param applicationGateWayName string = 'demo_task_appgw'
// param vnetname string ='Taskvnet1'
// param sku string ='Standard'
module vnet1 './modules/vnet1.bicep' = {
  name: 'myVnetModule' // Specify a name for the module instance
  params: {
    // Provide values for the module's parameters
    location: location
  }
}
 var appgw_subnet_id = vnet1.outputs.subnet1id
 var vm_subnet_id = vnet1.outputs.subnet2id
 var vnet1rsid = vnet1.outputs.vnet1rsid
 var fevnetname = vnet1.outputs.fevnet

module publicIP './modules/pubip.bicep'={
  name:'demopuplicip'
  params:{
    ip_name : 'demo-ip-gw'
     location : location
    dns_name :'demoipgwww234'
  }
}
var appgw_public_ip =  publicIP.outputs.ipResourceId
module vnet2 './modules/vnet2.bicep' ={
  name: 'Vnet2Module'
  params:{
    location  : location
    vnetname  :'Taskvnet2'
    subnetname1 :'Subnetname11'
    subnetname2 :'Subnetname223'
  }
}
var bevmsubnetid = vnet2.outputs.besubnetnameid
var bevnetrsid = vnet2.outputs.vnet2rsid
var bevnetname = vnet2.outputs.bevnetname

module BEvmnic 'modules/BEnic.bicep'= {
  name:'BEVMnicmodule'
  params: {
    bevm_subnet_id : bevmsubnetid
    location: location
  }
}
var benicid = BEvmnic.outputs.bevmnic

// module for end vm
module BEvm 'modules/BEVM.bicep'={
  name: 'BEVMmodule'
  params:{
    bevm_nic_id : benicid
    location: location
    adminPassword: 'Sasidharan*1998'
  }
}

module FEvmnic 'modules/networkinterface.bicep'= {
  name:'FEVMnicmodule'
  params: {
    vm_subnet_id : vm_subnet_id
    location: location
    // applicationGateWayName: applicationGateWayName
  }
}
var vm1nic = FEvmnic.outputs.vmnic
var fevmpriip = FEvmnic.outputs.privateIpAddress
var appgwnsg = FEvmnic.outputs.fensgid
// var appgwnicname = FEvmnic.outputs.fevmnicname
var fevmip = FEvmnic.outputs.puplicipaddress

module vm 'modules/FEVM.bicep'={
  name: 'FEvmmodule'
  params:{
    vm1nic : vm1nic
    location: location
    adminPassword: 'Sasidharan*1998'
  }
}
//  var FEvmid = vm.outputs.FEVMid

module vnetpeering 'modules/vnetpeering.bicep'={
  name: 'vnetpeeringmodule'
  params:{
    fevnetname: fevnetname
    bevnetname: bevnetname
    vnet1rsid: vnet1rsid
    bevnetrsid: bevnetrsid
    location: location
  }
}

module applicationgateway './modules/appgway.bicep' ={
   name:'applicationgatewayModule'
   params: {
     location:location
    //  capacity : 0
     applicationGateWayName: applicationGateWayName
     appgw_subnet_id: appgw_subnet_id
     appgw_public_ip: appgw_public_ip
    //  appgw_nsg_id: appgwnsg
    //  appgwnic_sub_id: vm_subnet_id
    //  appgwnicname : appgwnicname 
     fevmip: fevmpriip
    //  target_vm_id: FEvmid
    
  }
}

module Azuresqldb 'modules/SQLDB.bicep'={
  name:'SQLDBmodule'
  params:{
    location:location
    subnetid: bevmsubnetid
  }
}
