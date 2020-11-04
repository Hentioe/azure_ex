defmodule AzureEx.Model.VirtualNetworks.CreateOrUpdate do
  @moduledoc false

  use TypedStruct

  alias __MODULE__.{Properties, AddressSpace}

  typedstruct module: AddressSpace do
    @derive Jason.Encoder

    field :addressPrefixes, [String.t()]
  end

  typedstruct module: Properties do
    @derive Jason.Encoder

    field :addressSpace, AddressSpace.t()
  end

  typedstruct do
    @derive Jason.Encoder

    field :location, String.t()
    field :properties, Properties.t()
  end
end
