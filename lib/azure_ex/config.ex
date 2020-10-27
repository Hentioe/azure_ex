defmodule AzureEx.Config do
  @moduledoc false

  @default_timeout 1000 * 15
  @default_recv_timeout 1000 * 10

  @spec timeouts :: [timeout: integer(), recv_timeout: integer()]
  def timeouts,
    do: [
      timeout: get(:timeout, @default_timeout),
      recv_timeout: get(:recv_timeout, @default_recv_timeout)
    ]

  @spec tenant_id() :: binary
  def tenant_id, do: get(:tenant)
  @spec client_id() :: binary
  def client_id, do: get(:client_id)
  @spec client_secret() :: binary
  def client_secret, do: get(:client_secret)

  @spec get(atom(), any()) :: any()
  defp get(key, default \\ nil) do
    Application.get_env(:azure_ex, key, default)
  end
end
