defmodule AzureEx do
  @moduledoc """
  Documentation for `AzureEx`.
  """

  require AzureEx.DSL
  import AzureEx.DSL

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
end
