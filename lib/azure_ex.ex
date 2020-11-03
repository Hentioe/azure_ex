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
    "CreateOrUpdateNetworkInterfaces",
    "PUT https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkInterfaces/{networkInterfaceName}?api-version=2020-05-01"
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
end
