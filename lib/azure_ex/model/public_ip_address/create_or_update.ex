defmodule AzureEx.Model.PublicIPAddress.CreateOrUpdate do
  @moduledoc false

  use TypedStruct

  alias __MODULE__.{Properties}

  typedstruct module: Properties do
    @derive Jason.Encoder

    field :publicIPAddressVersion, String.t()
  end

  typedstruct do
    @derive Jason.Encoder

    field :id, String.t()
    field :location, String.t()
    field :properties, Properties.t(), default: %Properties{}
  end
end
