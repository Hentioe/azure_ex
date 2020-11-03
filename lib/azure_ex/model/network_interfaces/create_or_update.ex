defmodule AzureEx.Model.NetworkInterfaces.CreateOrUpdate do
  @moduledoc false

  use TypedStruct

  alias __MODULE__.{Properties, PublicIPAddress}

  typedstruct module: PublicIPAddress do
    @derive Jason.Encoder

    field :id, String.t()
    field :name, String.t()
  end

  typedstruct module: Subnet do
    @derive Jason.Encoder

    field :id, String.t()
  end

  typedstruct module: NetworkInterfaceIPConfiguration.Properties do
    @derive Jason.Encoder

    field :subnet, Subnet.t()
    field :publicIPAddress, PublicIPAddress.t()
  end

  typedstruct module: NetworkInterfaceIPConfiguration do
    @derive Jason.Encoder

    field :id, String.t()
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
