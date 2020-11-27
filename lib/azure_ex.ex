defmodule AzureEx do
  @moduledoc """
  Documentation for `AzureEx`.
  """

  require AzureEx.DSL
  import AzureEx.DSL

  defendpoint(
    "CreateOrUpdateVirtualMachines",
    "PUT https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}?api-version=2020-06-01"
  )

  defendpoint(
    "DeleteVirtualMachines",
    "DELETE https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}?api-version=2020-06-01"
  )

  defendpoint(
    "GetVirtualMachines",
    "GET https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}?api-version=2020-06-01"
  )

  defendpoint(
    "ListAllVirtualMachines",
    "GET https://management.azure.com/subscriptions/{subscriptionId}/providers/Microsoft.Compute/virtualMachines?api-version=2020-06-01"
  )

  defendpoint(
    "GetNetworkInterface",
    "GET https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkInterfaces/{networkInterfaceName}?api-version=2020-06-01"
  )

  defendpoint(
    "PowerOffVirtualMachines",
    "POST https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/powerOff?api-version=2020-06-01"
  )

  defendpoint(
    "StartVirtualMachines",
    "POST https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/start?api-version=2020-06-01"
  )

  defendpoint(
    "RestartVirtualMachines",
    "POST https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/restart?api-version=2020-06-01"
  )

  defendpoint(
    "InstanceViewVirtualMachines",
    "GET https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/instanceView?api-version=2020-06-01"
  )

  defendpoint(
    "CreateOrUpdateNetworkInterfaces",
    "PUT https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkInterfaces/{networkInterfaceName}?api-version=2020-05-01"
  )

  defendpoint(
    "GetVirtualNetworks",
    "GET https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}?api-version=2020-05-01"
  )

  defendpoint(
    "CreateOrUpdateVirtualNetworks",
    "PUT https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}?api-version=2020-05-01"
  )

  defendpoint(
    "GetSubnet",
    "GET https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}?api-version=2020-05-01"
  )

  defendpoint(
    "CreateOrUpdateSubnets",
    "PUT https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}?api-version=2020-05-01"
  )

  defendpoint(
    "DeleteNetworkInterfaces",
    "DELETE https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkInterfaces/{networkInterfaceName}?api-version=2020-05-01"
  )

  defendpoint(
    "CreateOrUpdatePublicIPAddress",
    "PUT https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/publicIPAddresses/{publicIpAddressName}?api-version=2020-05-01"
  )

  defendpoint(
    "DeletePublicIPAddress",
    "DELETE https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/publicIPAddresses/{publicIpAddressName}?api-version=2020-05-01"
  )

  defendpoint(
    "DeleteDisks",
    "DELETE https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/disks/{diskName}?api-version=2020-06-30"
  )

  defendpoint(
    "CreateSshPublicKeys",
    "PUT https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/sshPublicKeys/{sshPublicKeyName}?api-version=2020-06-01"
  )

  defendpoint(
    "GetSshPublicKeys",
    "GET https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/sshPublicKeys/{sshPublicKeyName}?api-version=2020-06-01"
  )

  defendpoint(
    "ListByReourceGroupSshPublicKeys",
    "GET https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/sshPublicKeys?api-version=2020-06-01"
  )

  defendpoint(
    "GenerateKeyPairSshPublicKeys",
    "POST https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/sshPublicKeys/{sshPublicKeyName}/generateKeyPair?api-version=2020-06-01"
  )

  defendpoint(
    "DeleteSshPublicKeys",
    "DELETE https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/sshPublicKeys/{sshPublicKeyName}?api-version=2020-06-01"
  )

  defendpoint(
    "ListMetrics",
    "GET https://management.azure.com/{resourceUri}/providers/microsoft.insights/metrics?api-version=2018-01-01"
  )

  defendpoint(
    "ListResources",
    "GET https://management.azure.com/subscriptions/{subscriptionId}/resources?api-version=2020-06-01"
  )

  defendpoint(
    "ListByResourceGroupResources",
    "GET https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/resources?api-version=2020-06-01"
  )
end
