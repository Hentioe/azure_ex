defmodule AzureEx.Model.NetworkInterfaces.CreateOrUpdate do
  @moduledoc false

  use TypedStruct

  alias __MODULE__.{Properties}

  typedstruct module: Subnet do
    @derive Jason.Encoder

    field :id, String.t()
  end

  typedstruct module: NetworkInterfaceIPConfiguration.Properties do
    @derive Jason.Encoder

    field :subnet, Subnet.t()
  end

  typedstruct module: NetworkInterfaceIPConfiguration do
    @derive Jason.Encoder

    field :name, String.t()
    field :properties, NetworkInterfaceIPConfiguration.Properties.t()
  end

  typedstruct module: Properties do
    @derive Jason.Encoder

    field :ipConfigurations, [NetworkInterfaceIPConfiguration.t()]
  end

  typedstruct do
    @derive Jason.Encoder

    field :id, String.t()

    field :location, String.t()
    field :properties, Properties.t(), default: %Properties{}
  end
end
