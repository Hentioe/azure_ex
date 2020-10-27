defmodule AzureEx.Application do
  @moduledoc false

  use Application

  def start(_tuple, _args) do
    opts = [strategy: :one_for_one, name: AzureEx.Supervisor]

    Supervisor.start_link([{AzureEx.TokenHosting, get_client_oauth_params()}], opts)
  end

  defp get_client_oauth_params do
    tenant = Application.get_env(:azure_ex, :tenant)
    client_id = Application.get_env(:azure_ex, :client_id)
    client_secret = Application.get_env(:azure_ex, :client_secret)

    [tenant: tenant, client_id: client_id, client_secret: client_secret]
  end
end
