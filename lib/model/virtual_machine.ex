defmodule AzureEx.Model.VirtualMachine do
  @moduledoc """
  A struct representing a virtual machine.
  """
  use TypedStruct

  typedstruct do
    @typedoc "Describes a Virtual Machine."

    # Resource Id.
    field :id, String.t()
    # Resource location.
    field :location, String.t()
    # Resource name.
    field :name, String.t()
    # Resource type.
    field :type, String.t()
    # The virtual machine zones.
    field :zones, [String.t()]
  end
end
