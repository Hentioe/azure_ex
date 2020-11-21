defmodule AzureEx.Model.SshPublicKeys.Create do
  @moduledoc false

  use TypedStruct

  alias __MODULE__.Properties

  typedstruct module: Properties do
    @derive Jason.Encoder

    field :publicKey, String.t()
  end

  typedstruct do
    @derive Jason.Encoder

    field :location, String.t()
    field :properties, Properties.t()
  end
end
