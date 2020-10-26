defmodule AzureEx.Request do
  @moduledoc """
  HTTP request functions.
  """

  alias AzureEx.Config

  @type params :: %{body: keyword | map}
  @type result :: any
  @type error :: any
  @type httpoison_result :: {:ok, HTTPoison.Response.t()} | {:error, HTTPoison.Error.t()}

  @spec call(binary, atom, params) ::
          {:ok, result} | {:error, error}
  def call(endpoint, method, params \\ %{body: %{}}) do
    method |> send(endpoint, params) |> handle_response()
  end

  @spec handle_response({:ok, HTTPoison.Response.t()}) :: {:ok, result} | {:error, error}
  def handle_response({:ok, %HTTPoison.Response{body: body}}) do
    {:ok, Jason.decode!(body, keys: :atoms)}
  end

  @spec send(:get, String.t(), params) :: httpoison_result
  def send(:get, endpoint, %{}) do
    HTTPoison.get(endpoint, [Authorization: "Bearer #{Config.access_token()}"], Config.timeouts())
  end
end
