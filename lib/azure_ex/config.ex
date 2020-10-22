defmodule AzureEx.Config do
  @moduledoc false

  @default_timeout 1000 * 15
  @default_recv_timeout 1000 * 10

  # TODO: 通过 oauth2 API 获取并自动刷新 access_token 替代硬编码配置
  @spec access_token :: String.t() | nil
  def access_token, do: get(:access_token)

  @spec subscription_id :: String.t() | nil
  def subscription_id, do: get(:subscription_id)

  @spec timeouts :: [timeout: integer(), recv_timeout: integer()]
  def timeouts,
    do: [
      timeout: get(:timeout, @default_timeout),
      recv_timeout: get(:recv_timeout, @default_recv_timeout)
    ]

  @spec get(atom(), any()) :: any()
  defp get(key, default \\ nil) do
    Application.get_env(:azure_ex, key, default)
  end
end
