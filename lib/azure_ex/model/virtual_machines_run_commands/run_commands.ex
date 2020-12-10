defmodule AzureEx.Model.VirtualMachinesRunCommands.RunCommand do
  @moduledoc false

  use TypedStruct

  alias __MODULE__.{RunCommandInputParameter}

  typedstruct do
    @derive Jason.Encoder

    field :commandId, String.t()
    field :parameters, [RunCommandInputParameter]
    field :script, [String]
  end
end
