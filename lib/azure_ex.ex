defmodule AzureEx do
  @moduledoc """
  Documentation for `AzureEx`.
  """

  require AzureEx.DSL
  import AzureEx.DSL

  defendpoint(
    "ListAllVirtualMachines",
    "https://management.azure.com/subscriptions/{subscriptionId}/providers/Microsoft.Compute/virtualMachines",
    {:get, "2020-06-01"}
  )

  defendpoint(
    "GetNetworkInterface",
    "https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkInterfaces/{networkInterfaceName}",
    {:get, "2020-06-01"}
  )
end
