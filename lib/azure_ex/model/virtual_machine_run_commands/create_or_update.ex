defmodule AzureEx.Model.VirtualMachineRunCommands.CreateOrUpdate do
  @moduledoc false

  use TypedStruct

  alias __MODULE__.{Properties, RunCommandInputParameter, VirtualMachineRunCommandScriptSource}

  typedstruct module: RunCommandInputParameter do
    @derive Jason.Encoder

    field :name, String.t()
    field :value, String.t()
  end

  typedstruct module: VirtualMachineRunCommandScriptSource do
    @derive Jason.Encoder

    field :commandId, String.t()
    field :script, String.t()
    field :scriptUri, String.t()
  end

  typedstruct module: Properties do
    @derive Jason.Encoder

    field :asyncExecution, boolean()
    field :parameters, [RunCommandInputParameter]
    field :protectedParameters, [RunCommandInputParameter]
    field :runAsPassword, String.t()
    field :runAsUser, String.t()
    field :source, VirtualMachineRunCommandScriptSource.t()
    field :timeoutInSeconds, integer
  end

  typedstruct do
    @derive Jason.Encoder

    field :location, String.t()
    field :properties, Properties.t()
  end
end
