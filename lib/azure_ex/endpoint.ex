defmodule AzureEx.Endpoint do
  @moduledoc false

  require AzureEx.DSL
  import AzureEx.DSL

  defendpoint(
    "ListAllVirtualMachines",
    "https://management.azure.com/subscriptions/{subscriptionId}/providers/Microsoft.Compute/virtualMachines"
  )

  @doc """
      iex> AzureEx.Endpoint.get_network_interface("sub-1", "resgp-1", "net-1", api_version: "2020-1-1")
      "https://management.azure.com/subscriptions/sub-1/resourceGroups/resgp-1/providers/Microsoft.Network/networkInterfaces/net-1?api_version=2020-1-1"
  """
  defendpoint(
    "GetNetworkInterface",
    "https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkInterfaces/{networkInterfaceName}"
  )
end
