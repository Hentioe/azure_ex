defmodule AzureEx.Request do
  @moduledoc """
  HTTP request functions.
  """

  alias AzureEx.Config

  @api_version "2020-06-01"

  def endpoint(api),
    do:
      "https://management.azure.com/subscriptions/#{Config.subscription_id()}/providers/Microsoft.Compute/#{
        api
      }?api-version=#{@api_version}"

  @type params :: %{query_params: keyword | map, body: keyword | map}
  @type result :: any
  @type error :: any
  @type httpoison_result :: {:ok, HTTPoison.Response.t()} | {:error, HTTPoison.Error.t()}

  @spec call(binary, atom, params) ::
          {:ok, result} | {:error, error}
  def call(api, method, params \\ %{query_params: %{}, body: %{}}) do
    method |> send(endpoint(api), params) |> handle_response()
  end

  @spec handle_response({:ok, HTTPoison.Response.t()}) :: {:ok, result} | {:error, error}
  def handle_response({:ok, %HTTPoison.Response{body: body}}) do
    body |> Jason.decode!(keys: :atoms)
  end

  @spec send(:get, String.t(), params) :: httpoison_result
  def send(:get, endpoint, %{query_params: query_params}) do
    endpoint = endpoint <> to_query(query_params)

    HTTPoison.get(endpoint, [Authorization: "Bearer #{Config.access_token()}"], Config.timeouts())
  end

  def to_query(params, opts \\ []) when is_list(params) or is_map(params) do
    prefix_question = Keyword.get(opts, :prefix_question, false)

    # TODO: 待实现
    str = ""

    if prefix_question, do: "?" <> str, else: str
  end
end
