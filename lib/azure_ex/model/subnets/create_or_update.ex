defmodule AzureEx.Model.Subnets.CreateOrUpdate do
  @moduledoc false

  use TypedStruct

  alias __MODULE__.Properties

  typedstruct module: Properties do
    @derive Jason.Encoder

    field :addressPrefix, String.t()
  end

  typedstruct do
    @derive Jason.Encoder

    field :name, String.t()
    field :properties, Properties.t()
  end
end
