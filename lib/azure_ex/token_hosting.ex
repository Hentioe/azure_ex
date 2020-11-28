defmodule AzureEx.TokenHosting do
  @moduledoc false

  # TODO: 轮询检查令牌有效性。

  use GenServer

  defmodule Token do
    @moduledoc false

    defstruct [:access_token, :expires_in, :created_at]

    @type t :: %__MODULE__{
            access_token: binary,
            expires_in: integer,
            created_at: NaiveDateTime.t()
          }

    def new(%{access_token: access_token, expires_in: expires_in}) do
      created_at = NaiveDateTime.utc_now()

      %__MODULE__{access_token: access_token, expires_in: expires_in, created_at: created_at}
    end
  end

  defmodule Params do
    @moduledoc false

    defstruct [:tenant, :client_id, :client_secret]

    @type t :: %__MODULE__{
            tenant: binary,
            client_id: binary,
            client_secret: binary
          }
  end

  def start_link(opts \\ []) do
    name = Keyword.get(opts, :name, __MODULE__)
    tenant = Keyword.get(opts, :tenant)
    client_id = Keyword.get(opts, :client_id)
    client_secret = Keyword.get(opts, :client_secret)
    params = %Params{tenant: tenant, client_id: client_id, client_secret: client_secret}

    {:ok, token} = apply_token(params)

    GenServer.start_link(__MODULE__, %{params: params, token: token}, name: name)
  end

  @scope "https://management.azure.com//.default"
  @grant_type "client_credentials"
  @headers [{"Content-Type", "application/x-www-form-urlencoded"}]

  @spec apply_token(Params.t()) :: {:ok, Token.t()} | {:error, binary}
  defp apply_token(%{tenant: tt, client_id: ci, client_secret: cs}) do
    endpoint = "https://login.microsoftonline.com/#{tt}/oauth2/v2.0/token"

    form = [
      client_id: ci,
      scope: @scope,
      client_secret: cs,
      grant_type: @grant_type
    ]

    case HTTPoison.post(endpoint, {:form, form}, @headers) do
      {:ok, %HTTPoison.Response{body: body}} ->
        token = body |> Jason.decode!(keys: :atoms) |> Token.new()

        {:ok, token}

      {:error, e} ->
        # TODO: 超时等网络问题自动重试
        # TODO: 抽象出错误模型
        # TODO: 记录日志
        {:error, inspect(e)}
    end
  end

  @impl true
  def init(state) do
    schedule_token_refresh()

    {:ok, state}
  end

  def get_token do
    GenServer.call(__MODULE__, :get)
  end

  @impl true
  def handle_call(:get, _from, %{token: %{access_token: at}} = state) do
    {:reply, at, state}
  end

  @impl true
  def handle_info(:refresh, %{params: params} = state) do
    {:ok, token} = apply_token(params)

    schedule_token_refresh()
    {:noreply, %{state | token: token}}
  end

  @interval 1000 * 3500

  defp schedule_token_refresh do
    Process.send_after(__MODULE__, :refresh, @interval)
  end
end
