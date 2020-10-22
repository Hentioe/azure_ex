defmodule AzureEx.Model.VirtualMachineListResult do
  @moduledoc """
  A struct representing a list virtual machine operation response.
  """

  use TypedStruct

  typedstruct do
    @typedoc "The List Virtual Machine operation response."

    # The URI to fetch the next page of VMs.
    # Call ListNext() with this URI to fetch the next page of Virtual Machines.
    field :next_link, String.t()
    # The list of virtual machines.
    field :value, [AzureEx.Model.VirtualMachine.t()]
  end
end
